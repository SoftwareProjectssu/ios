//
//  MyhairModel.swift
//  hAIr
//
//  Created by 한태빈 on 5/12/25.
//

import Foundation

struct HairModel: Identifiable {
    let id = UUID()
    let imageName: String   // 로컬 asset 이름 또는 URL
    let title: String
}
