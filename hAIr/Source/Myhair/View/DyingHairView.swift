import SwiftUI

struct DyingHairView: View {
    @Environment(\.dismiss) private var dismiss
    let imageName: String    // AppliedHairCardView 에서 받아온 이름

    // 색상 옵션과 이름을 한 곳에 정의
    private let colorOptions: [(name: String, color: Color)] = [
        ("검정", .black),
        ("회색", .gray),
        ("보라", .purple),
        ("금색", .yellow),
        ("흰색", .white)
    ]

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 320, height: 440, alignment: .center)
                .padding()

            // 이미지 아래 색상 버튼과 레이블
            HStack(spacing: 24) {
                ForEach(colorOptions, id: \.name) { option in
                    VStack(spacing: 8) {
                        Button {
                            print("\(option.name) 버튼 탭됨")
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
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // 왼쪽 검정 화살표
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.black)
                }
            }
            // 가운데 타이틀
            ToolbarItem(placement: .principal) {
                Text("염색하기")
                    .font(.pretendard(.semibold, size: 20))
                    .foregroundColor(.black)
            }
        }
    }
}
