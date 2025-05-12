//
//  CardView.swift
//  hAIr
//
//  Created by 한태빈 on 5/8/25.
//
import SwiftUI

struct TrendHairCardView: View {
    let item: TrendHairItem

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Capsule()
                .fill(Color.gray.opacity(0.4))
                .frame(width: 40, height: 5)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 8)

            Text(item.description)
                .font(.pretendard(.bold, size: 20))

            Text(item.detail)
                .font(.pretendard(.semibold, size: 16))

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 350)
        .background(Color.buttongray) // 버튼 회색
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .shadow(radius: 10)
        .padding(.bottom,0)
                 }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
