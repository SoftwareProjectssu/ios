//
//  SignupViewModel.swift
//  hAIr
//
//  Created by 소민준 on 5/28/25.
//

import SwiftUI
import Combine
import Moya
import UIKit

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
    private let provider = MoyaProvider<SignupEndpoint>(plugins: [NetworkLoggerPlugin()])
    private var cancellables = Set<AnyCancellable>()

    /// Perform signup request with server, upload image and user info.
    /// - Parameter completion: Called on main thread with `true` if succeeded, `false` otherwise.
    func signup(completion: @escaping (Bool) -> Void) {
        // 1️⃣ 입력 검증
        guard let image = selectedImage,
              let imageData = image.jpegData(compressionQuality: 0.8),
              let kakaoToken = KeychainHelper.shared.get(forKey: "kakaoAccessToken")
        else {
            self.errorMessage = "모든 필드를 입력하고 프로필 사진을 선택해주세요."
            print("🚫 SignupViewModel: validation failed")
            completion(false)
            return
        }

        // 2️⃣ 로딩 시작
        isLoading = true
        errorMessage = nil
        print("🚀 SignupViewModel: starting signup request")

        // 3️⃣ DTO 생성
        let dto = SignupRequestDTO(
            accessToken: kakaoToken,
            nickname: nickname,
            faceType: faceType,
            sex: sex
        )

        // 4️⃣ 네트워크 요청
        provider.request(.signup(data: dto, imageData: imageData)) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false

                switch result {
                case .success(let response):
                    print("✅ SignupViewModel: received response, statusCode=\(response.statusCode)")
                    do {
                        let signupResponse = try JSONDecoder().decode(SignupResponseDTO.self, from: response.data)
                        print("🔔 SignupViewModel: decoded response: \(signupResponse)")

                        // 5️⃣ 로컬 저장
                        UserDefaults.standard.set(self.nickname, forKey: "nickname")
                        UserDefaults.standard.set(imageData, forKey: "profilePhoto")
                        KeychainHelper.shared.save(signupResponse.data.token, forKey: "accessToken")
                        print("🔒 SignupViewModel: saved token to Keychain")

                        completion(true)
                    } catch {
                        print("❌ SignupViewModel: decoding error: \(error)")
                        self.errorMessage = "응답 처리 실패: \(error.localizedDescription)"
                        completion(false)
                    }

                case .failure(let error):
                    if case let MoyaError.statusCode(response) = error {
                        let responseString = String(data: response.data, encoding: .utf8) ?? "Invalid response data"
                        print("🚨 SignupViewModel: server error body: \(responseString)")
                    }
                    print("❌ SignupViewModel: network error: \(error.localizedDescription)")
                    self.errorMessage = "회원가입 요청 실패: \(error.localizedDescription)"
                    completion(false)
                }
            }
        }
    }
}
