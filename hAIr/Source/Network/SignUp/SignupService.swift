//
//  SignupService.swift
//  hAIr
//
//  Created by 소민준 on 5/28/25.
//


import Foundation
import Moya

final class SignupService {

    static let shared = SignupService()
    private let provider = MoyaProvider<SignupEndpoint>()

    private init() {}

    func signup(data: SignupRequestDTO, completion: @escaping (Result<Void, Error>) -> Void) {
        provider.request(.signup(data: data)) { result in
            switch result {
            case .success(let response):
                do {
                    if (200..<300).contains(response.statusCode) {
                        completion(.success(()))
                    } else {
                        let errorMessage = String(data: response.data, encoding: .utf8) ?? "Unknown error"
                        completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
