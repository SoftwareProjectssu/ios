//
//  LoadingView.swift
//  hAIr
//
//  Created by 소민준 on 5/13/25.
//


import SwiftUI

struct LoadingView: View {
    var onComplete: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            LottieView(animationName: "Animation - 1747141608429")
                .frame(width: 180, height: 180)

            Text("머리를 적용 중입니다...")
                .font(.pretendard(.medium, size: 16))
                .foregroundColor(.gray)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.opacity(0.95))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                onComplete()
            }
        }
    }
}
