//
//  NavigationRouter.swift
//  hAIr
//
//  Created by 한태빈 on 5/7/25.
//

import SwiftUI

/// 앱 내에서 가능한 화면(경로)를 Hashable로 정의
enum Route: Hashable {
    case home
    case ai
    case myHair
    case myPage
    case login
    
}

final class NavigationRouter: ObservableObject {
    /// 전역 네비게이션 스택
    @Published var path = NavigationPath()
    /// 로그인 상태
    @Published var isLoggedIn = false
    /// 현재 선택된 탭(Route)
    @Published var selectedTab: Route = .home

    /// 로그인 성공 후 홈으로
    func toHome() {
        selectedTab = .home
        //path = NavigationPath([ Route.home ])   // ← Route.home으로 명시
        isLoggedIn = true
        path = NavigationPath() 
    }

    /// 로그아웃 또는 로그인 화면으로
    func toLogin() {
        selectedTab = .login
        path = NavigationPath([ Route.login ])  // ← Route.login으로 명시
        isLoggedIn = false
    }

    /// 특정 경로로 이동 (탭 변경 및 스택 초기화)
    func push(_ route: Route) {
        selectedTab = route
        path = NavigationPath([ route ])        // ← 배열이 [Route]
    }

    /// 스택에서 뒤로 한 단계
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
}
