import SwiftUI
import Foundation

struct LoginView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        VStack(alignment: .leading) {
            loginInfo
            loginButton
        }
        .padding(.horizontal, 90)
    }
    
    private var loginInfo: some View {
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
    
    private var loginButton: some View {
        VStack(alignment: .center) {
            Button {
                KakaoAuthService.shared.handleKakaoLogin { result in
                    switch result {
                    case .success(let accessToken):
                        print("✅ 카카오 로그인 성공: \(accessToken)")
                        checkSignupStatus(token: accessToken)
                    case .failure(let error):
                        print("❌ 카카오 로그인 실패: \(error.localizedDescription)")
                    }
                }
            } label: {
                Image("kakaologin")
                    .resizable()
                    .frame(width: 305, height: 45)
            }
            .padding(.bottom, 15)
            
            Button {
                router.toHome()
            } label: {
                Image("applelogin")
                    .resizable()
                    .frame(width: 305, height: 45)
            }
        }
    }
    
    func checkSignupStatus(token: String) {
        KakaoAuthService.shared.checkKakaoRegistration(token: token) { isRegistered in
            DispatchQueue.main.async {
                if isRegistered {
                    router.toHome()
                } else {
                    // 👉 서버 요청 전에 kakaoToken 저장 필요
                    KeychainHelper.shared.save(token, forKey: "kakaoAccessToken")
                    router.toSignup()
                }
            }
        }
    }
}

#Preview {
    LoginView().environmentObject(NavigationRouter()) // ← 프리뷰에서도 router 주입
}
