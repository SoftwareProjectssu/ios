import SwiftUI
import UIKit

// Helper shape for rounding specific corners
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}


struct ApplyHairCardView: View {
    let item: ApplyHairItem
    @ObservedObject var viewModel: ApplyHairViewModel
    @State private var showMenu = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 1) 드래그용 캡슐 표시선
            Capsule()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 40, height: 5)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 8)

            // 2) 제목(스타일명) + ⋯ 버튼
            HStack {
                Text(item.description)
                    .font(.title3).bold()
                    .foregroundColor(.primary)
                Spacer()
                Button { showMenu.toggle() } label: {
                    Image("dot_button")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                }
                .foregroundColor(.black)
                .buttonStyle(PlainButtonStyle())
            }
            // 3) 상세 설명
            Text(item.detail)
                .font(.body)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 350)
        .background(Color.buttongray)              // 프로젝트에 정의된 버튼 그레이 컬러
        .clipShape(RoundedCorner(radius: 20, corners: [.topLeft, .topRight]))
        .shadow(radius: 10)
        .ignoresSafeArea(edges: .bottom)
        .overlay(alignment: .topTrailing) {
            if showMenu {
                VStack(spacing: 0) {
                    Button("저장하기") {
                        // viewModel.save(item)
                        showMenu = false
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 4)

                    Divider()

                    Button("적용하기") {
                        // viewModel.apply(item)
                        showMenu = false
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 4)
                }
                .frame(width: 120)
                .background(Color(.systemBackground))
                .cornerRadius(8)
                .offset(x: -16, y: 72)
            }
        }
    }
}
