//
//  hAIrApp.swift
//  hAIr
//
//  Created by 한태빈 on 5/7/25.
//

import SwiftUI

@main
struct hAirtestApp: App {
    @StateObject private var router = NavigationRouter()

    var body: some Scene {
        WindowGroup {
            // ① NavigationStack 본체
            NavigationStack(path: $router.path) {
                // ② 로그인 여부에 따라 루트 뷰 결정
                if router.isLoggedIn {
                    TabbarView()
                } else {
                    LoginView()
                }
            }
            // ③ Route 타입별 destination 매핑
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .home:      HomeView()
                case .ai:        AIView()
                case .myHair:    MyHairView()
                case .myPage:    MyPageView()
                case .login:     LoginView()
                }
            }
            // ④ 전체에 router 주입
            .environmentObject(router)
        }
    }
}
