//
//  CardView.swift
//  hAIr
//
//  Created by 한태빈 on 5/8/25.
//
import SwiftUI

struct ApplyHairCardView: View {
    let item: ApplyHairItem

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Capsule()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 40, height: 5)
                .padding(.top, 8)

            Text(item.description)
                .font(.title3)
                .bold()

            Text(item.detail)
                .font(.body)

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 370)
        .background(Color.buttongray) // 버튼 회색
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .shadow(radius: 10)
        .ignoresSafeArea(edges: .bottom)
    }
}

