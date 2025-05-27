import SwiftUI

struct HairCardView: View {
    let imageName: String
    let title: String
    var onDismiss: (() -> Void)?   // 외부에서 닫기 액션을 넘겨 받을 수도 있고

    @State private var showMenu = false

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            // 1) 삭제 및 메뉴 버튼 세로 배치
            VStack(spacing: 8) {
                Button {
                    onDismiss?()
                } label: {
                    Image("delete")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.black)
                }
                Button {
                    showMenu.toggle()
                } label: {
                    Image("dot_button")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.black)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.top)
            .padding(.trailing, 20)   // 오른쪽 여백 추가
            .frame(maxWidth: .infinity, alignment: .trailing)

            // 2) 큰 이미지
            Image(imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(12)
                .padding(.horizontal)

            // 3) 제목 (중앙 정렬)
            Text(title)
                .font(.pretendard(.bold, size: 20))
                .frame(maxWidth: .infinity, alignment: .center)

            Spacer()
        }
        .padding(.vertical)
        .background(Color.buttongray)
        .cornerRadius(20)
        .shadow(radius: 10)
        // 카드 뷰 폭을 넓히고 싶을 때, 패딩을 줄입니다.
        .padding(.horizontal, 40)
        .overlay(alignment: .topTrailing) {
            if showMenu {
                VStack(spacing: 0) {
                    Button("염색하기") {
                        showMenu = false
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 4)

                    Divider()

                    Button("적용하기") {
                        onDismiss?()
                        showMenu = false
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 4)
                }
                .frame(width: 100)
                .background(Color(.systemBackground))
                .cornerRadius(8)
                .offset(x: -52, y: 90)
            }
        }
    }
}
