//
//  HairCardView.swift
//  hAIr
//
//  Created by 한태빈 on 5/13/25.
//

import SwiftUI

struct AIHairCardView: View {
    let imageName: String
    let title: String
    let onDismiss: (() -> Void)?

    
    var body: some View {
        VStack(spacing: 16) {
            // 닫기, 휴지통 버튼을 수평으로 배치
            HStack {
                Button {
                    onDismiss?()
                } label: {
                    Image("delete")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.black)
                }
                Spacer()
                Button(action: {
                    // 염색하기 기능 실행
                }) {
                    Text("적용하기")
                        .font(.pretendard(.medium, size: 14))
                        .foregroundColor(.black)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background(Color.white)
                        .clipShape(Capsule()) // <-- 타원형 모양 만들기
                }
                Spacer()
                Button {
                    onDismiss?()
                } label: {
                    Image("trashbin")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 20)

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
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 32)
    }
}
