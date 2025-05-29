//  AIResultView.swift
//  hAIr
//
//  Created by 소민준 on 5/13/25.

import SwiftUI

struct AIResultView: View {
    @EnvironmentObject var router: NavigationRouter
    let selectedImage: UIImage?

    var body: some View {
        VStack(spacing: 16) {
            // 제목
            Text("A.I 추천 결과")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 20)

            // 이미지 표시
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                    .clipped()
                    .cornerRadius(10)
            }

            Spacer()

            // 추천받은 머리 보러가기 버튼
            Button(action: {
                withAnimation {
                    router.selectedTab = .myHair
                }
            }) {
                Text("추천받은 머리 보러가기")
                    .foregroundColor(Color("navy"))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color("navy"), lineWidth: 1)
                    )
                    .cornerRadius(12)
                    .padding(.horizontal)
            }
            .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
    }
}
#Preview {
    AIResultView().environmentObject(NavigationRouter())
}
