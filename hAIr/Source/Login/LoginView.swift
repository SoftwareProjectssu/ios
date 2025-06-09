import SwiftUI
import Foundation
import Moya

struct LoginView: View {
    @EnvironmentObject var router: NavigationRouter

    var body: some View {
        VStack(alignment: .leading) {
            loginInfo
            loginButton
        }
        .padding(.horizontal, 90)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .gesture(DragGesture())
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
            // ✅ 카카오 로그인 버튼
            Button(action: {
                KakaoAuthService.shared.handleKakaoLogin(router: router) { result in
                    switch result {
                    case .success:
                        print("✅ 카카오 로그인 성공")
                        // 실제 전환은 KakaoAuthService 내에서 처리됨
                    case .failure(let error):
                        print("❌ 카카오 로그인 실패: \(error.localizedDescription)")

                        // 서버 응답 에러 400일 경우에만 회원가입 화면으로 이동
                        if let moyaError = error as? MoyaError,
                           case .statusCode(let response) = moyaError,
                           response.statusCode == 400 {
                            print("🟡 회원가입이 필요한 사용자 → SignupView로 이동")
                            router.isLoggedIn = true
                            router.path = NavigationPath()
                            router.path.append(Route.signup)
                        } else {
                            print("🛑 로그인 중 다른 네트워크 오류 발생 → stay on LoginView")
                            // 아무 화면 이동도 하지 않음
                        }
                    }
                }
            }, label: {
                Image("kakaologin")
                    .resizable()
                    .frame(width: 305, height: 45)
            })
            .padding(.bottom, 15)

            // 애플 로그인 버튼 (예시)
            Button {
                router.toHome()
            } label: {
                Image("applelogin")
                    .resizable()
                    .frame(width: 305, height: 45)
            }
        }
        
    }
}

#Preview {
    LoginView().environmentObject(NavigationRouter())
}
