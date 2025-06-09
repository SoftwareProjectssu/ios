import SwiftUI

struct SplashView: View {
    @EnvironmentObject var router: NavigationRouter
    @State private var isActive = false

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack {
                Spacer()
                Image("logo") // Assets에 있는 로고 이미지 이름
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180)
                Spacer()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                router.tryAutoLoginOnce() // ✅ 이제 한번만 실행됨
                isActive = true
            }
        }
        // 이건 App 진입 직후 Splash만 보여주고, 라우터에 따라 뷰가 바뀌도록
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}
