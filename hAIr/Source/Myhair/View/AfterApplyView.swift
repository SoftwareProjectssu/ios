//
//  AfterDyeView.swift
//  hAIr
//
//  Created by 소민준 on 5/30/25.
//

import SwiftUI

struct AfterApplyView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Image("applyimage")
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 300)
                .clipped()
                .cornerRadius(10)
            Text("머리스타일 적용이 완료되었습니다.")
                .font(.pretendard(.regular, size: 16))
                .padding(.top, 60)
        }
        .padding(.horizontal)
        .padding(.top)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // 왼쪽 검정 화살표
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.black)
                }
            }
            // 가운데 타이틀
            ToolbarItem(placement: .principal) {
                Text("적용된 머리 확인하기")
                    .font(.pretendard(.semibold, size: 20))
                    .foregroundColor(.black)
            }
        }
    }
}

