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
            HairModel(imageName: "trend1", title: "가르마펌"),
            HairModel(imageName: "trend2", title: "가일컷"),
            HairModel(imageName: "trend3", title: "리프컷"),
            HairModel(imageName: "trend4", title: "히피펌"),
            HairModel(imageName: "trend3", title: "리프컷"),
            HairModel(imageName: "trend4", title: "히피펌")
        ]
        let applied: [HairModel] = [
            HairModel(imageName: "apply1", title: "히피펌"),
            HairModel(imageName: "apply2", title: "단발 레이어드컷"),
            HairModel(imageName: "apply3", title: "단발 c컬"),
            HairModel(imageName: "apply4", title: "장발 s컬")
        ]

        self.aiVM = HairGridViewModel(items: recommended)
        self.appliedVM = HairGridViewModel(items: applied)
    }
}
