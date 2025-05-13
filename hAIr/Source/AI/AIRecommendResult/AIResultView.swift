//
//  AIResultView.swift
//  hAIr
//
//  Created by 소민준 on 5/13/25.
//

import SwiftUI



struct AIResultView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedHair: AIHairViewModel?

var body: some View {
    VStack(alignment: .leading) {
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

        Text("A.I 추천 결과")
            .font(.system(size: 24, weight: .semibold))
            .padding(.bottom, 45)
            .padding(.top, 16)
            .frame(maxWidth: .infinity, alignment: .center)

        LazyVGrid(columns: [GridItem(.flexible(), spacing: 21), GridItem(.flexible(), spacing: 21)], spacing: 21) {
            ForEach(0..<4, id: \.self) { index in
                Button(action: {
                    print("🔥 선택된 인덱스: \(index)")
                    selectedHair = AIHairViewModel(hairId: index)
                }) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 168, height: 221)
                        .cornerRadius(8)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal)
    }
    .navigationBarBackButtonHidden(true)
    .navigationDestination(item: $selectedHair) { viewModel in
        ApplyingLoadingView(viewModel: viewModel)
    }
}
}

#Preview {
    AIResultView()
}
