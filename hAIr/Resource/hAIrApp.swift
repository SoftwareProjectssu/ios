import SwiftUI
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import Foundation

@main
struct hAIrApp: App {
    @StateObject private var router = NavigationRouter()
    
    init() {
        KakaoSDK.initSDK(appKey: "13d54b6fa95cfc4c7f973d2701d947bc")
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                Group {
                    if router.isLoggedIn {
                        TabbarView()
                    } else {
                        LoginView()
                    }
                }
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .home:
                        HomeView()
                    case .ai:
                        AIView()
                    case .myHair:
                        MyHairView()
                    case .myPage:
                        MyPageView()
                    case .login:
                        LoginView()
                    case .signup:
                        SignupView()
                    }
                }
            }
            .environmentObject(router)
            .onAppear {
                checkAutoLogin()  // ✅ 여기가 핵심
            }
            .onOpenURL { url in
                if AuthApi.isKakaoTalkLoginUrl(url) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            }
        }
    }
    
    // ✅ 자동 로그인 로직
    func checkAutoLogin() {
        print("🔥 checkAutoLogin() called")
        
        if let token = KeychainHelper.shared.get(forKey: "jwtToken") {
            print("✅ JWT 로드 성공: \(token)")
            let hasSignedUp = UserDefaults.standard.bool(forKey: "hasSignedUp")
            print("✅ 회원가입 여부: \(hasSignedUp)")
            
            if hasSignedUp {
                print("✅ 자동 로그인: 홈으로 이동")
                router.isLoggedIn = true
                router.path = NavigationPath()
            } else {
                print("🟡 자동 로그인: 회원가입 안 됨 → SignupView")
                router.isLoggedIn = true
                router.path = NavigationPath()
                router.path.append(Route.signup)
            }
        } else {
            print("❌ 자동 로그인 실패: JWT 없음")
            router.isLoggedIn = false
        }
    }
}

