import SwiftUI
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser



@main
struct hAIrApp: App {
    @StateObject private var router = NavigationRouter()

    init() {
        KakaoSDK.initSDK(appKey: "13d54b6fa95cfc4c7f973d2701d947bc")
    }

    var body: some Scene {
        WindowGroup {
            // ← 여기만 NavigationStack을 씁니다
            NavigationStack(path: $router.path) {
                Group {
                    if router.isLoggedIn {
                        TabbarView()
                    } else {
                        LoginView()
                    }
                }
                // ← 그리고 여기에 Route 전부 매핑
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
            .environmentObject(router)    // router 환경 객체도 여기만!
            .onOpenURL { url in
                if AuthApi.isKakaoTalkLoginUrl(url) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            }
        }
    }
}
