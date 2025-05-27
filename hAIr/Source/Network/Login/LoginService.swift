//
//  LoginService.swift
//  hAIr
//
//  Created by 소민준 on 5/28/25.
//


import Foundation
import Moya

final class LoginService {
    static let shared = LoginService()
    private let provider = MoyaProvider<LoginEndpoint>()

    private init() {}

    func login(
        with dto: LoginRequestDTO,
        completion: @escaping (Result<LoginResponseDTO, Error>) -> Void
    ) {
        provider.request(.login(data: dto)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(LoginResponseDTO.self, from: response.data)
                    completion(.success(decoded))
                } catch {
                    print("❌ 로그인 응답 디코딩 실패:", error)
                    completion(.failure(error))
                }
            case .failure(let error):
                print("❌ 로그인 네트워크 실패:", error)
                completion(.failure(error))
            }
        }
    }
}
