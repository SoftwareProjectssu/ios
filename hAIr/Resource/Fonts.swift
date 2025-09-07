//
//  Font.swift
//  hAIr
//
//  Created by 한태빈 on 5/7/25.
//

import Foundation
import SwiftUI

extension Font {
    static func pretendard(_ weight: Pretend, size: CGFloat) -> Font {
        .custom(weight.value, size: size)
    }
    
    enum Pretend: String {
        case extraBold = "Pretendard-ExtraBold"
        case bold = "Pretendard-Bold"
        case semibold = "Pretendard-SemiBold"
        case medium = "Pretendard-Medium"
        case regular = "Pretendard-Regular"
        case light = "Pretendard-Light"
        
        var value: String { self.rawValue }
    }
}

//사용법 복사해서 쓰셈 .font(.pretendard(.semibold, size: 16))

