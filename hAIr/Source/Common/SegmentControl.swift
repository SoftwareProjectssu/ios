//
//  SegmentControl.swift
//  hAIr
//
//  Created by 한태빈 on 5/12/25.
//

import SwiftUI

/// RawValue가 String이고 CaseIterable & Identifiable을 동시에 만족하는 Enum만 받을 수 있는
/// 제네릭 세그먼트 컨트롤
struct SegmentControl<T>: View
where
    T: RawRepresentable & CaseIterable & Identifiable,
    T.RawValue == String
{
    @Binding var selection: T
    var horizontalPadding: CGFloat = 20
    var verticalPadding: CGFloat = 0
    var indicatorColor: Color = .navy

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(T.allCases)) { tab in
                VStack(spacing: 0) {
                    Button {
                        withAnimation { selection = tab }
                    } label: {
                        Text(tab.rawValue)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(selection == tab ? .black : .gray)
                            .frame(maxWidth: .infinity)
                    }
                    Capsule()
                        .fill(selection == tab ? indicatorColor : .clear)
                        .frame(height: 3)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal, horizontalPadding)
        .padding(.vertical, verticalPadding)
        .background(Color.white)
    }
}
