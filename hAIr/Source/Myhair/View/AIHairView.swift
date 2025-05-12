// AIHairView.swift

import SwiftUI

struct AIHairView: View {
    @ObservedObject var viewModel: HairGridViewModel
    let onSelect: (HairModel) -> Void

    var body: some View {
        VStack(spacing: 0) {
            // 1) 제목
            Text("AI한테 추천받은 머리스타일 모음")
                .font(.pretendard(.semibold, size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.bottom, 16)

            // 2) 슬라이더
            TabView(selection: $viewModel.currentPage) {
                ForEach(Array(viewModel.pages.enumerated()), id: \.offset) { idx, pageItems in
                    VStack(spacing: 0) {
                        HairGridView(items: pageItems, onItemTap: onSelect)
                        Spacer()  // 나머지 공간을 아래로 밀어냄
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tag(idx)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(height: 420)

            // 3) 페이지 인디케이터
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
        // 화면 전체 높이를 채워서 VStack 내부 Spacer가 동작하도록
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}
