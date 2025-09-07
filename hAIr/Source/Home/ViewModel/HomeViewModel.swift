//
//  HomeViewModel.swift
//  hAIr
//
//  Created by 한태빈 on 5/12/25.
//

import SwiftUI

// 1) 탭 정의 (기존 파일 그대로)
enum HomeTab: String, CaseIterable, Identifiable {
    case trend    = "new trend"
    case apply    = "most apply"
    case magazine = "Magazine"
    var id: String { self.rawValue }
}

// 2) 실제 화면 상태 관리 뷰모델
final class HomeViewModel: ObservableObject {
    @Published var selectedTab: HomeTab = .trend

    // (선택) 탭별 뷰모델을 미리 생성해 두면,
    // 탭 전환 시에도 각 서브뷰의 페이지 상태가 유지됩니다.
    let trendVM = TrendHairViewModel()
    let applyVM = ApplyHairViewModel()
}
