//
//  HairGridViewModel.swift
//  hAIr
//
//  Created by 한태빈 on 5/13/25.
//

import SwiftUI

/// 공통 그리드(Paging) 로직을 갖는 ViewModel
final class HairGridViewModel: ObservableObject {
    @Published var currentPage: Int = 0
    let items: [HairModel]    // 화면에 뿌릴 원본 리스트

    /// 9개씩 잘라서 [[HairModel]] 형태의 페이지 배열 생성
    var pages: [[HairModel]] {
        stride(from: 0, to: items.count, by: 9).map { start in
            let end = min(start + 9, items.count)
            return Array(items[start..<end])
        }
    }

    init(items: [HairModel]) {
        self.items = items
    }
}
