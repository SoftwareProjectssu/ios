import SwiftUI

@main
struct hAirtestApp: App {
    @StateObject private var router = NavigationRouter()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                if router.isLoggedIn {
                    TabbarView()
                } else {
                    LoginView()
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .home:   HomeView()
                case .ai:     AIView()
                case .myHair: MyHairView()
                case .myPage: MyPageView()
                case .login:  LoginView()
                }
            }
            .environmentObject(router)
        }
    }
}
