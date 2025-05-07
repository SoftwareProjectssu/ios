//
//  TabbarView.swift
//  hAIr
//
//  Created by 한태빈 on 5/7/25.
//
import SwiftUI

struct TabbarView: View {
    @EnvironmentObject var router: NavigationRouter

    private let tabs:   [Route] = [.home, .ai, .myHair, .myPage]
    private let icons = ["home", "ai", "myhair", "mypage"]
    private let titles = ["홈", "AI 추천", "내 머리스타일", "마이페이지"]

    var body: some View {
        VStack(spacing: 0) {
            topBar
            contentView
            tabBar
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.bottom)
    }

    // MARK: — TopBar
    private var topBar: some View {
        TopBarView(title: titles[currentIndex])
            .environmentObject(router)
    }

    // MARK: — Content
    @ViewBuilder
    private var contentView: some View {
        switch tabs[currentIndex] {
        case .home:   HomeView()
        case .ai:     AIView()
        case .myHair: MyHairView()
        case .myPage: MyPageView()
        @unknown default:
            EmptyView()
        }
    }

    // MARK: — TabBar
    private var tabBar: some View {
        HStack(spacing: 44) {
            ForEach(Array(zip(tabs.indices, tabs)), id: \.0) { idx, route in
                Button {
                    router.push(route)
                } label: {
                    Image(icons[idx])
                        .renderingMode(.template)            // ① 템플릿 모드
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(
                            router.selectedTab == route ? .black : .gray
                        )
                        .padding(.top, 15)
                }
                .frame(maxWidth: .infinity)
                .buttonStyle(.plain)
            }
        }
        .frame(height: 83)
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }

    // MARK: — Helpers
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
                .padding(.leading, 23.5)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 80)
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
