// HairGridView.swift
// hAIr

import SwiftUI

struct HairGridView: View {
    let items: [HairModel]
    var onItemTap: ((HairModel) -> Void)? = nil

    private let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(items) { hair in
                Image(hair.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 132)
                    .clipped()
                    .cornerRadius(4)
                    .onTapGesture {
                        onItemTap?(hair)
                    }
            }
        }
        .padding(.horizontal)
    }
}
