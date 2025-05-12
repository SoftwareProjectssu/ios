// MyHairView.swift
// hAIr

import SwiftUI

struct MyHairView: View {
    @StateObject private var vm = MyHairViewModel()
    @State private var showCard = false
    @State private var selectedHair: HairModel?

    var body: some View {
        VStack(spacing: 32) {
            SegmentControl(selection: $vm.selectedTab)

            ZStack {
                switch vm.selectedTab {
                case .aihair:
                    AIHairView(viewModel: vm.aiVM) { hair in
                        selectedHair = hair
                        withAnimation(.easeInOut) { showCard = true }
                    }
                case .applyhair:
                    AppliedHairView(viewModel: vm.appliedVM) { hair in
                        selectedHair = hair
                        withAnimation(.easeInOut) { showCard = true }
                    }
                }
            }
        }
        .padding(.top, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
            ZStack {
                if showCard, let hair = selectedHair {
                  
                    // 2) 중앙 팝업 카드
                    HairCardView(
                        imageName: hair.imageName,
                        title: hair.title,
                        onDismiss: {
                            withAnimation(.easeInOut) { showCard = false }
                        }
                    )
                    .frame(width: 400, height: 500)      // 원하는 크기로 고정
                    .transition(.scale)                  // 팝업 애니메이션
                }
            }
        )
        // showCard 값이 바뀔 때마다 애니메이션 적용
        .animation(.easeInOut, value: showCard)
    }
}
