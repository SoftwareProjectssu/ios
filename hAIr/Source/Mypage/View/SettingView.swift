//  SettingView.swift
//  hAIr
//
//  Created by 한태빈 on 5/29/25.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {

            VStack(spacing: 45) {
                HStack {
                    Image("Myprofile")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 54, height: 54)
                    Text("내 계정")
                        .font(.pretendard(.regular, size: 20))
                    Spacer()
                    Image("leftarrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                }

                HStack {
                    Image("Question")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 54, height: 54)
                    Text("Q & A")
                        .font(.pretendard(.regular, size: 20))
                    Spacer()
                    Image("leftarrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                }

                HStack {
                    Image("logout")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 54, height: 54)
                    Text("로그아웃")
                        .font(.pretendard(.regular, size: 20))
                    Spacer()
                    Image("leftarrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)

            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // 왼쪽에 검정색 뒤로 가기 화살표만
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.black)
                }
            }
            // 가운데에 커스텀 타이틀
            ToolbarItem(placement: .principal) {
                Text("설정 및 활동")
                    .font(.pretendard(.semibold, size: 20))
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingView()
    }
}
