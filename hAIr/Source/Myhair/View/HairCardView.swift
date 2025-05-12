//
//  HairCardView.swift
//  hAIr
//
//  Created by 한태빈 on 5/13/25.
//

import SwiftUI

struct HairCardView: View {
    let imageName: String
    let title: String
    var onDismiss: (() -> Void)?   // 외부에서 닫기 액션을 넘겨 받을 수도 있고

    var body: some View {
        VStack(spacing: 16) {
            // 닫기 버튼
            HStack {
                Spacer()
                Button {
                    onDismiss?()
                } label: {
                    Image("delete")
                        .foregroundColor(.black)
                }
            }
            .padding(.trailing)

            // 큰 이미지
            Image(imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(12)
                .padding(.horizontal)

            // 제목
            Text(title)
                .font(.pretendard(.bold, size: 20))
                .padding(.horizontal)

            Spacer()
        }
        .padding(.vertical)
        .background(Color.buttongray)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(.horizontal, 16)
    }
}
