//
//  NavigationRouter.swift
//  hAIr
//
//  Created by 한태빈 on 5/7/25.
//

import SwiftUI

/// 앱 내에서 가능한 화면(경로)를 Hashable로 정의
enum Route: Hashable {
    case home, ai, myHair, myPage
    
    case login
    
    case signup
}

final class NavigationRouter: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var path = NavigationPath()
    @Published var selectedTab: Route = .home
    
    /// 앱 실행 시 토큰 존재 여부 확인
    func checkIfLoggedIn() {
        if let token = KeychainHelper.shared.get(forKey: "jwtToken"), !token.isEmpty {
            self.isLoggedIn = true
        } else {
            self.isLoggedIn = false
        }
    }
    
    /// 로그인 성공 후 홈으로
    func toHome() {
        selectedTab = .home
        isLoggedIn = true
        path = NavigationPath()
    }
    
    /// 로그아웃 또는 로그인 화면으로
    func toLogin() {
        selectedTab = .login
        path = NavigationPath([ Route.login ])
        isLoggedIn = false
    }
    
    func toSignup() {
        selectedTab = .signup
        path = NavigationPath([Route.signup])
    }
    
    /// 특정 경로로 이동 (탭 변경 및 스택 초기화)
    func push(_ route: Route) {
        selectedTab = route
        path = NavigationPath([ route ])
    }
    
    /// 스택에서 뒤로 한 단계
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    /// 자동 로그인 시도
    /// 앱 실행 시 카카오 accessToken으로 자동 로그인 시도
    func tryAutoLogin() {
        guard let kakaoAccessToken = KeychainHelper.shared.get(forKey: "jwtToken") else {
            self.isLoggedIn = false
            return
        }
        
        let dto = LoginRequestDTO(accessToken: kakaoAccessToken)
        
        LoginService.shared.login(with: dto) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    // JWT 토큰 저장
                    KeychainHelper.shared.save(response.data.token, forKey: "jwtToken")
                    self.toHome()
                case .failure:
                    self.toLogin()
                }
            }
        }
    }
}
