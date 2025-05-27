import SwiftUI
import Combine
import Moya

/// ViewModel for handling signup flow, including sending data to server and local storage
final class SignupViewModel: ObservableObject {
    // MARK: - Input Properties
    @Published var nickname: String = ""
    @Published var faceType: String = ""
    @Published var sex: String = ""
    @Published var selectedImage: UIImage? = nil

    // MARK: - State Properties
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    // MARK: - Dependencies
    private let provider = MoyaProvider<AuthEndpoint>()
    private var cancellables = Set<AnyCancellable>()

    /// Perform signup request with server, upload image and user info.
    /// - Parameter completion: Called on main thread with `true` if succeeded, `false` otherwise.
    func signup(completion: @escaping (Bool) -> Void) {
        // Validate inputs
        guard let image = selectedImage,
              let imageData = image.jpegData(compressionQuality: 0.8),
              let kakaoToken = KeychainHelper.shared.get(forKey: "kakaoAccessToken")
        else {
            self.errorMessage = "모든 필드를 입력하고 프로필 사진을 선택해주세요."
            completion(false)
            return
        }
        
        // Prepare and send request
        isLoading = true
        errorMessage = nil
        
        provider.request(.register(
            accessToken: kakaoToken,
            nickname: nickname,
            faceType: faceType,
            sex: sex,
            imageData: imageData
        )) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false

                switch result {
                case .success(let response):
                    do {
                        let dto = try JSONDecoder().decode(SignupResponseDTO.self, from: response.data)
                        // Local storage: nickname
                        UserDefaults.standard.set(self.nickname, forKey: "nickname")
                        // Local storage: store image data (not ideal for large images)
                        UserDefaults.standard.set(imageData, forKey: "profilePhoto")
                        // Save JWT token to keychain
                        KeychainHelper.shared.set(dto.data.token, forKey: "accessToken")

                        completion(true)
                    } catch {
                        self.errorMessage = "응답 처리 실패: \(error.localizedDescription)"
                        completion(false)
                    }

                case .failure(let error):
                    self.errorMessage = "회원가입 요청 실패: \(error.localizedDescription)"
                    completion(false)
                }
            }
        }
    }
}
