//
//  AIHairViewModel.swift
//  hAIr
//
//  Created by 소민준 on 5/13/25.
//


import Foundation
import SwiftUI

class AIHairViewModel: ObservableObject, Identifiable, Hashable {
    let id = UUID() // Identifiable을 위한 고유 ID
    let hairId: Int

    @Published var hairImageURL: String = ""
    @Published var isHairApplied: Bool = false

    init(hairId: Int) {
        self.hairId = hairId
        self.hairImageURL = "hair_\(hairId)"
    }

    func applyHair() {
        isHairApplied = true
    }

    // MARK: - Hashable 구현
    static func == (lhs: AIHairViewModel, rhs: AIHairViewModel) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

