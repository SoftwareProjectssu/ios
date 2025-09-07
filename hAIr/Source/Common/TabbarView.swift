// TabbarView.swift

import SwiftUI

struct TabbarView: View {
    @EnvironmentObject var router: NavigationRouter

    private let tabs:   [Route] = [.home, .ai, .myHair, .myPage]
    private let icons = ["home", "ai", "myhair", "mypage"]
    private let titles = ["Home", "AI Recommand", "My Hair Style", "My Page"]

    var body: some View {
        GeometryReader { geometry in
            // 로그인 상태 등에서 selectedTab이 탭에 포함되지 않으면 뷰 자체를 숨깁니다
            if tabs.contains(router.selectedTab) {
                ZStack(alignment: .bottom) {
                    VStack(spacing: 0) {
                        // Top bar
                        topBar

                        // 콘텐츠 영역
                        ZStack {
                            Color.white
                            contentView
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }

                    // 탭 바
                    tabBar
                        .frame(width: geometry.size.width, height: 83)
                        .background(Color.white)
                        .shadow(color: .black.opacity(0.05), radius: 5, y: -2)
                }
                .edgesIgnoringSafeArea(.bottom)
            } else {
                EmptyView()
            }
        }
    }

    // MARK: — Top Bar
    private var topBar: some View {
        TopBarView()
    }

    // MARK: — Content
    @ViewBuilder
    private var contentView: some View {
        if let index = tabs.firstIndex(of: router.selectedTab) {
            switch tabs[index] {
            case .home:    HomeView()
            case .ai:      AIView()
            case .myHair:  MyHairView()
            case .myPage:  MyPageView()
            @unknown default:
                EmptyView()
            }
        } else {
            EmptyView()
        }
    }

    // MARK: — Tab Bar
    private var tabBar: some View {
        HStack(spacing: 20) {
            ForEach(Array(zip(tabs.indices, tabs)), id: \.0) { idx, route in
                Button {
                    router.selectedTab = route
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
    }

    // MARK: — Helper
    private var currentIndex: Int {
        tabs.firstIndex(of: router.selectedTab) ?? 0
    }
}

// ──────────────────────────────────────────────────────────────────────────────
// TopBarView.swift

struct TopBarView: View {
    var body: some View {
        HStack {
            Text("hA.Ir")
                .font(.pretendard(.bold, size: 28))
                .foregroundStyle(Color(.navy))
            Spacer()
        }
        .padding(.leading, 20)
        .frame(height: 50)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        // ────────────────────────────────────────
        // TabBar와 비슷한 그림자 추가
        .shadow(
            color: .black.opacity(0.05),  // 그림자 색상
            radius: 5,                     // 번짐(퍼짐) 반경
            x: 0,                          // 수평 오프셋
            y: 2                           // 수직 오프셋 (양수면 아래로)
        )
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
        TopBarView()
    }
}
#endif
