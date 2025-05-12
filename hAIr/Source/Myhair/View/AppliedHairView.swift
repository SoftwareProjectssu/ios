//
//  AppliedHairView.swift
//  hAIr
//
//  Created by 한태빈 on 5/13/25.
//

// AppliedHairView.swift

import SwiftUI

struct AppliedHairView: View {
    @ObservedObject var viewModel: HairGridViewModel
    let onSelect: (HairModel) -> Void

    var body: some View {
        VStack(spacing: 0) {
            // 1) 제목
            Text("내가 적용해본 머리스타일 모음")
                .font(.pretendard(.semibold, size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.bottom, 16)
            
            // 2) Spacer 기법을 쓴 TabView
            TabView(selection: $viewModel.currentPage) {
                ForEach(Array(viewModel.pages.enumerated()), id: \.offset) { idx, pageItems in
                    VStack(spacing: 0) {
                        // 그리드를 상단에 붙이고…
                        HairGridView(items: pageItems, onItemTap: onSelect)
                        // 나머지 공간은 아래로 밀어냅니다
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tag(idx)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 420)
            
            HStack(spacing: 8) {
                ForEach(0..<viewModel.pages.count, id: \.self) { idx in
                    Circle()
                        .fill(idx == viewModel.currentPage ? Color.navy : Color.buttongray)
                        .overlay(Circle().stroke(Color.black, lineWidth: 0.5))
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.top, 40)
        }
        // 최상위 VStack도 화면 전체를 채우도록
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
