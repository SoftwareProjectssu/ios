//
//  HomeView.swift
//  hAIr
//
//  Created by 한태빈 on 5/7/25.
//

// HomeView.swift

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // 1) 공통 세그먼트 컨트롤
            SegmentControl(selection: $vm.selectedTab)

            // 2) 탭별 화면 전환
            switch vm.selectedTab {
            case .trend:
                TrendHairView(viewModel: vm.trendVM)
            case .apply:
                ApplyHairView(viewModel: vm.applyVM)
            case .magazine:
                MagazineView()
            }
        }
        // 화면 전체를 채우고, VStack 안의 내용은 항상 위쪽에 정렬
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.top, 16) //topbar와의 간격
    }
}



#Preview {
    HomeView()
}
