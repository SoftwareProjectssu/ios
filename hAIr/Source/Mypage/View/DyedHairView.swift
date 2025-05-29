//
//  DyedHairView.swift
//  hAIr
//
//  Created by 한태빈 on 5/29/25.
//

import SwiftUI

struct DyedHairView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: DyedHairViewModel
    var onItemTap: ((HairModel) -> Void)? = nil

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(viewModel.items) { hair in
                        Image(hair.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width:112, height: 132)
                            .clipped()
                            .cornerRadius(4)
                            .onTapGesture {
                                onItemTap?(hair)
                            }
                    }
                }
                .padding(.horizontal)
                .padding(.top)
            }
            .frame(maxWidth: .infinity, alignment: .top) // 상단 정렬
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.black)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("염색한 머리 모음")
                    .font(.pretendard(.semibold, size: 20))
                    .foregroundColor(.black)
            }
        }
    }
}
