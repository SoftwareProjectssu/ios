//
//  SplashView.swift
//  hAIr
//
//  Created by 소민준 on 5/29/25.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var router: NavigationRouter

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 160)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                checkAutoLogin()
            }
        }
    }

    private func checkAutoLogin() {
        print("🔥 checkAutoLogin() called")
        if let token = KeychainHelper.shared.get(forKey: "jwtToken") {
            print("✅ JWT 로드 성공: \(token)")
            let hasSignedUp = UserDefaults.standard.bool(forKey: "hasSignedUp")
            print("✅ 회원가입 여부: \(hasSignedUp)")

            router.isLoggedIn = true
            if hasSignedUp {
                print("✅ 자동 로그인 → 홈(TabbarView)")
                router.path = NavigationPath()
            } else {
                print("🟡 자동 로그인: 회원가입 안 됨 → SignupView")
                router.path = NavigationPath()
                router.path.append(Route.signup)
            }
        } else {
            print("❌ 자동 로그인 실패: JWT 없음 → 로그인")
            router.isLoggedIn = false
            router.path = NavigationPath()
            router.path.append(Route.login)
        }
    }
}
