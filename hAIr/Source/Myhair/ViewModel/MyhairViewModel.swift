// MyhairViewModel.swift
// hAIr

import SwiftUI

enum HairTab: String, CaseIterable, Identifiable {
    case aihair    = "AI가 추천한 머리"
    case applyhair = "내가 적용해 본 머리"
    var id: String { rawValue }
}

final class MyHairViewModel: ObservableObject {
    @Published var selectedTab: HairTab = .aihair

    let aiVM: HairGridViewModel
    let appliedVM: HairGridViewModel

    init() {
        let recommended: [HairModel] = [
            HairModel(imageName: "trend1", title: "가르마펌"),
            HairModel(imageName: "trend2", title: "가일컷"),
            HairModel(imageName: "trend3", title: "리프컷"),
            HairModel(imageName: "trend4", title: "히피펌"),
            HairModel(imageName: "trend5", title: "크롭컷"),
            HairModel(imageName: "trend7", title: "투블럭"),
            HairModel(imageName: "trend8", title: "쉐도우펌"),
            HairModel(imageName: "trend9", title: "애즈펌"),
            HairModel(imageName: "trend10", title: "댄디컷"),
            HairModel(imageName: "trend6", title: "포마드")

        ]
        let applied: [HairModel] = [
            HairModel(imageName: "applyimage", title: "포마드")
//            HairModel(imageName: "apply1", title: "히피펌"),
//            HairModel(imageName: "apply2", title: "단발 레이어드컷"),
//            HairModel(imageName: "apply3", title: "단발 c컬"),
//            HairModel(imageName: "apply4", title: "장발 s컬"),
//            HairModel(imageName: "apply5", title: "히메컷"),
//            HairModel(imageName: "apply6", title: "젤리펌"),
//            HairModel(imageName: "apply7", title: "보브컷"),
//            HairModel(imageName: "apply8", title: "태슬컷"),
//            HairModel(imageName: "apply9", title: "허쉬컷")
        ]

        self.aiVM = HairGridViewModel(items: recommended)
        self.appliedVM = HairGridViewModel(items: applied)
    }
}
