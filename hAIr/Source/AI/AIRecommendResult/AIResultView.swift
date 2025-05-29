//  AIResultView.swift
//  hAIr
//
//  Created by 소민준 on 5/13/25.

import SwiftUI

struct AIResultView: View {
    @EnvironmentObject var router: NavigationRouter
    @ObservedObject var viewModel: AIViewModel
    let selectedImage: UIImage?

    var body: some View {
        VStack(spacing: 16) {
            Text("A.I 추천 결과")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 32)

            if let image = selectedImage ?? viewModel.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                    .clipped()
                    .cornerRadius(10)
            }

            Spacer().frame(height: 40)

            VStack(spacing: 12) {
                // ✅ 추천받은 머리 보러가기
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

                // ✅ 다시 추천받기
                Button(action: {
                    viewModel.reset()
                    router.resultImage = nil
                    router.aiState = .main
                }) {
                    Text("다시 추천받기")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.red, lineWidth: 1)
                        )
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
            }

            Spacer().frame(height: 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarBackButtonHidden(true)
    }
}
