import SwiftUI

struct TabbarView: View {
    @EnvironmentObject var router: NavigationRouter

    private let tabs: [Route] = [.home, .ai, .myHair, .myPage]
    private let icons = ["home", "ai", "myhair", "mypage"]
    private let titles = ["Home", "AI Recommand", "My Hair Style", "My Page"]

    var body: some View {
        GeometryReader { geometry in
            // 로그인 상태 등에서 selectedTab이 탭에 포함되지 않으면 렌더링 자체 안함
            if tabs.contains(router.selectedTab) {
                ZStack(alignment: .bottom) {
                    VStack(spacing: 0) {
                        topBar

                        ZStack {
                            Color.white
                            contentView
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }

                    tabBar
                        .frame(width: geometry.size.width, height: 83)
                        .background(Color.white)
                        .shadow(color: .black.opacity(0.05), radius: 5, y: -2)
                }
                .edgesIgnoringSafeArea(.bottom)
                .background(Color.white)
            } else {
                EmptyView() // login 상태 등에서는 TabbarView 자체 숨김
            }
        }
    }

    // MARK: - TopBar
    private var topBar: some View {
        TopBarView(title: titles[currentIndex])
            .environmentObject(router)
    }

    // MARK: - Content
    @ViewBuilder
    private var contentView: some View {
        if let index = tabs.firstIndex(of: router.selectedTab) {
            switch tabs[index] {
            case .home:   HomeView()
            case .ai:     AIView()
            case .myHair: MyHairView()
            case .myPage: MyPageView()
            @unknown default:
                // 이 상황은 절대 발생하지 않지만, Swift의 switch exhaustiveness를 만족시키기 위해 추가
                EmptyView()
            }
        } else {
            EmptyView()
        }
    }


    // MARK: - TabBar
    private var tabBar: some View {
        HStack(spacing: 20) {
            ForEach(Array(zip(tabs.indices, tabs)), id: \.0) { idx, route in
                Button {
                    router.selectedTab = route  // push 대신 단순 탭 전환
                } label: {
                    Image(icons[idx])
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(router.selectedTab == route ? .black : .gray)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.plain)
            }
        }
        .frame(height: 83)
    }

    // MARK: - Helpers
    private var currentIndex: Int {
        tabs.firstIndex(of: router.selectedTab) ?? 0
    }
}

struct TopBarView: View {
    @EnvironmentObject var router: NavigationRouter
    var title: String

    var body: some View {
        HStack {
            Text(title)
                .padding(.leading, 20)
                .font(.pretendard(.bold, size: 24))
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 40)
        .background(Color.white)
    }
}

#if DEBUG
struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        let router = NavigationRouter()
        router.isLoggedIn = true
        router.selectedTab = .home
        router.path = NavigationPath([Route.home])
        return TabbarView().environmentObject(router)
    }
}

struct TopBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopBarView(title: "홈").environmentObject(NavigationRouter())
    }
}
#endif
