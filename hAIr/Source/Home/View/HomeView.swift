//
//  HomeView.swift
//  hAIr
//
//  Created by 한태빈 on 5/7/25.
//

import SwiftUI

import SwiftUI

enum HomeTab: String, CaseIterable, Identifiable {
    case trend = "new trend"
    case apply = "most apply"
    case magazine = "Magazine"

    var id: String { self.rawValue }
}

struct HomeView: View {
    @State private var selectedTab: HomeTab = .trend

    var body: some View {
        VStack(spacing: 0) {
            HStack{
                Spacer().frame(width: 10)
                ForEach(HomeTab.allCases) { tab in
                    VStack {
                        Button {
                            selectedTab = tab
                        } label: {
                            Text(tab.rawValue)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(selectedTab == tab ? .black : .gray)
                        }
                        .padding(.horizontal)

                        if selectedTab == tab {
                            Capsule()
                                .fill(Color.navy)
                                .frame(height: 3)
                        } else {
                            Color.clear.frame(height: 3)
                        }
                    }
                }
                Spacer()
            }
            .padding(.top, -50) // ← TopBar 기준 여백 고정
            .padding(.bottom, 8)
            // 탭에 따른 화면 전환
            switch selectedTab {
            case .trend:
                TrendHairView().frame(minHeight: 600)
            case .apply:
                ApplyHairView().frame(minHeight: 600)
            case .magazine:
                MagazineView().frame(minHeight: 600)
            }
        }
    }
}


#Preview {
    HomeView()
}
