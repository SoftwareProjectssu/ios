//
//  LoginView.swift
//  hAIr
//
//  Created by 한태빈 on 5/7/25.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack(alignment: .leading){
            loginInfo
            loginButton
        }
        .padding(.horizontal, 90)   // 좌우 90pt 여백
    }
}

private var loginInfo: some View {
    Group{
        VStack(alignment: .leading) {
            Image("logo")
                .resizable()
                .frame(width: 107, height: 161)
            Spacer().frame(height: 15)
            Text("헤어스타일 관리 서비스\nhAIr에 가입하여 더 나은 스타일을 찾아보세요")
                .font(.pretendard(.semibold, size: 20))
                .foregroundStyle(Color(.navy))
            Spacer().frame(height: 180)
        }
    }
}

private var loginButton: some View {
    VStack(alignment: .center){
        Image("kakaologin")
            .resizable()
            .frame(width: 305, height: 45)
            .padding(.bottom,15)
        Image("applelogin")
            .resizable()
            .frame(width: 305, height: 45)
    }
}
#Preview {
    LoginView()
}
