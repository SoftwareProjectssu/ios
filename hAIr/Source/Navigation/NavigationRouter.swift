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
    @Published var hasInitialized: Bool = false
    private var hasTriedAutoLogin: Bool = false

    // MARK: - 로그인 상태 확인 (앱 시작 시)
    func checkIfLoggedIn() {
        if let token = KeychainHelper.shared.get(forKey: "jwtToken"), !token.isEmpty {
            self.isLoggedIn = true
        } else {
            self.isLoggedIn = false
        }
    }

    // MARK: - 자동 로그인 (앱 재실행 시)
    func tryAutoLogin() {
            if let jwt = KeychainHelper.shared.get(forKey: "jwtToken"), !jwt.isEmpty {
                print("✅ JWT 존재: 자동 로그인 성공")
                self.toHome()
            } else {
                print("❌ JWT 없음: 로그인 필요")
                self.toLogin()
            }

            // ✅ 무조건 true로 설정
            self.hasInitialized = true
        }
    // MARK: - 자동 로그인 1회만 시도
    func tryAutoLoginOnce() {
        guard !hasTriedAutoLogin else {
            print("🟡 이미 자동 로그인 시도함")
            return
        }
        hasTriedAutoLogin = true
        tryAutoLogin()
    }

    // MARK: - 라우팅 함수들

    /// 로그인 성공 후 홈으로
    func toHome() {
        selectedTab = .home
        isLoggedIn = true
        path = NavigationPath()
    }

    /// 로그인 화면으로 이동
    func toLogin() {
        selectedTab = .login
        path = NavigationPath([ Route.login ])
        isLoggedIn = false
    }

    /// 회원가입 화면으로 이동
    func toSignup() {
        selectedTab = .signup
        path = NavigationPath([ Route.signup ])
    }

    /// 특정 화면으로 이동
    func push(_ route: Route) {
        selectedTab = route
        path = NavigationPath([ route ])
    }

    /// 뒤로가기
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
}
