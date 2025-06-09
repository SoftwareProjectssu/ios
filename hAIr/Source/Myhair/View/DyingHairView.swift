import SwiftUI

struct DyingHairView: View {
    @EnvironmentObject private var router: NavigationRouter
    @Environment(\.dismiss) private var dismiss
    let imageName: String

    @State private var isLoading = false
    @State private var navigateToNext = false
    @State private var selectedColor: String?

    private let colorOptions: [(name: String, color: Color)] = [
        ("검정", .black),
        ("회색", .gray),
        ("보라", .purple),
        ("금색", .yellow),
        ("흰색", .white)
    ]

    var body: some View {
        ZStack {
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 320, height: 440)
                    .padding()

                HStack(spacing: 24) {
                    ForEach(colorOptions, id: \.name) { option in
                        VStack(spacing: 0) {
                            Button {
                                selectedColor = option.name
                                isLoading = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                    isLoading = false
                                    navigateToNext = true
                                }
                            } label: {
                                Circle()
                                    .stroke(option.color == .white ? Color.buttongray : option.color, lineWidth: 2)
                                    .background(
                                        Circle()
                                            .fill(option.color.opacity(option.color == .white ? 0.0 : 0.2))
                                    )
                                    .frame(width: 40, height: 40)
                            }

                            Text(option.name)
                                .font(.pretendard(.regular, size: 12))
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(.vertical, 16)

                Spacer()
            }

            // ✅ 전체 화면 덮는 로딩 뷰
            if isLoading {
                SimpleLoadingView()
            }

            // ✅ 다음 화면으로 이동
            NavigationLink("", destination: AfterDyeView(), isActive: $navigateToNext)
                .hidden()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.black)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("염색하기")
                    .font(.pretendard(.semibold, size: 20))
                    .foregroundColor(.black)
            }
        }
    }
}
