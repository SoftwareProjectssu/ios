import Foundation
import SwiftUI

struct ApplyingLoadingView: View {
    @ObservedObject var viewModel: AIHairViewModel
    @State private var navigate = false

    var body: some View {
        VStack(spacing: 16) {
            LottieView(animationName: "Animation - 1747141608429")
                .frame(width: 180, height: 180)

            Text("머리를 적용 중입니다...")
                .font(.pretendard(.medium, size: 16))
                .foregroundColor(.gray)

            NavigationLink(destination: HairApplyingView(viewModel: viewModel), isActive: $navigate) {
                EmptyView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.opacity(0.95))
        .contentShape(Rectangle())
        .multilineTextAlignment(.center)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                navigate = true
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
