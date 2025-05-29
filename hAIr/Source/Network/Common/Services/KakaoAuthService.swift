//
//  KakaoAuthService.swift
//  hAIr
//
//  Created by 소민준 on 5/11/25.
//

import KakaoSDKUser
import KakaoSDKAuth
import Foundation
import Moya
import SwiftUI


final class KakaoAuthService {
    static let shared = KakaoAuthService()
    private init() {}
    
    func handleKakaoLogin(router: NavigationRouter, completion: @escaping (Result<Void, Error>) -> Void) {
        let performLogin: (OAuthToken) -> Void = { oauthToken in
            let kakaoAccessToken = oauthToken.accessToken
            print("✅ 카카오 토큰 받아옴: \(kakaoAccessToken)")
            
            // 서버에 로그인 시도 (회원가입 여부 판단 목적)
            self.checkKakaoRegistration(token: kakaoAccessToken) { isRegistered in
                if isRegistered {
                    // 이미 가입된 사용자 → JWT 저장됐을 것임
                    router.isLoggedIn = true
                    router.path = NavigationPath()
                    completion(.success(()))
                } else {
                    // 회원가입이 필요한 경우 → 토큰만 저장해두고 SignupView로 이동
                    KeychainHelper.shared.save(kakaoAccessToken, forKey: "accessToken")
                    router.isLoggedIn = true
                    router.path = NavigationPath()
                    router.path.append(Route.signup)
                    completion(.success(()))
                }
                
            }
        }
        
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { token, error in
                if let token = token {
                    performLogin(token)
                } else {
                    completion(.failure(error ?? NSError(domain: "KakaoLogin", code: -1)))
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { token, error in
                if let token = token {
                    performLogin(token)
                } else {
                    completion(.failure(error ?? NSError(domain: "KakaoLogin", code: -1)))
                }
            }
        }
    }
    func checkKakaoRegistration(token: String, completion: @escaping (Bool) -> Void) {
        let dto = LoginRequestDTO(accessToken: token)
        LoginService.shared.login(with: dto) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    // ✅ 서버가 준 JWT를 저장해야 함
                    
                    completion(true)
                    
                case .failure(let error):
                    if let moyaError = error as? MoyaError,
                       case .statusCode(let response) = moyaError,
                       response.statusCode == 400 {
                        completion(false) // 회원가입 필요
                    } else {
                        completion(false)
                    }
                }
            }
        }
    }
}
