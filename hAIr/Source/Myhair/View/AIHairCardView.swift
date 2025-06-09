import SwiftUI

struct AIHairCardView: View {
    @EnvironmentObject private var router: NavigationRouter
    let imageName: String
    let title: String
    let onDismiss: (() -> Void)?
    
    @State private var navigateToNext = false
    @State private var isLoading = false

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                HStack {
                    Button {
                        onDismiss?()
                    } label: {
                        Image("delete")
                            .resizable()
                            .frame(width: 28, height: 28)
                    }
                    Spacer()
                    Button {
                        isLoading = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            isLoading = false
                            navigateToNext = true
                        }
                    } label: {
                        Text("적용하기")
                            .font(.pretendard(.medium, size: 14))
                            .foregroundColor(.black)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 20)
                            .background(Color.white)
                            .clipShape(Capsule())
                    }
                    Spacer()
                    Button {
                        onDismiss?()
                    } label: {
                        Image("trashbin")
                            .resizable()
                            .frame(width: 28, height: 28)
                    }
                }
                .padding(.horizontal, 20)

                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding(.horizontal)

                Text(title)
                    .font(.pretendard(.bold, size: 20))
                    .padding(.horizontal)

                Spacer()
            }
            .padding(.vertical)
            .background(Color.buttongray)
            .cornerRadius(20)
            .shadow(radius: 10)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 32)

            // ✅ 로딩 뷰는 여기서 전체 덮음
            if isLoading {
                SimpleLoadingView()
            }

            // ✅ 네비게이션도 여기서
            NavigationLink("", destination: AfterApplyView(), isActive: $navigateToNext)
                .hidden()
        }
    }
}
