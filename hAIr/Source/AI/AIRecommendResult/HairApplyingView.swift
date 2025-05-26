//
//  HairApplyingView.swift
//  hAIr
//
//  Created by 소민준 on 5/13/25.
//

import SwiftUI

struct HairApplyingView: View {
    @ObservedObject var viewModel: AIHairViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.black)
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 16)

            VStack {
                Text("머리 적용 완료!")
                Image(viewModel.hairImageURL)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 240, height: 300)
                    .cornerRadius(12)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
