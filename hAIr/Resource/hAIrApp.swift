//
//  hAIrApp.swift
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

@main
struct hAIrApp: App {
    @StateObject private var router = NavigationRouter()
    @StateObject private var aiViewModel = AIViewModel()
    
    init() {
        KakaoSDK.initSDK(appKey: "13d54b6fa95cfc4c7f973d2701d947bc")
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                Group {
                    if !router.hasInitialized {
                        SplashView()
                    } else if router.isLoggedIn {
                        TabbarView()
                    } else {
                        LoginView()
                    }
                }
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .home: HomeView()
                    case .ai: AIView(viewModel: aiViewModel)
                    case .myHair: MyHairView()
                    case .myPage: MyPageView()
                    case .login: LoginView()
                    case .signup: SignupView()
                    }
                }
            }
            .environmentObject(router)
            .onOpenURL { url in
                if AuthApi.isKakaoTalkLoginUrl(url) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            }
        }
    }
}
