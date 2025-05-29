// MyhairViewModel.swift
// hAIr

import SwiftUI


final class DyedHairViewModel: ObservableObject {
    @Published var items: [HairModel]

    init() {
        self.items = [
            HairModel(imageName: "apply1", title: "가르마펌"),
            HairModel(imageName: "apply2", title: "가일컷"),
            HairModel(imageName: "apply3", title: "리프컷"),
            HairModel(imageName: "apply4", title: "히피펌"),
            HairModel(imageName: "apply5", title: "가르마펌"),
            HairModel(imageName: "apply6", title: "가일컷"),
            HairModel(imageName: "apply7", title: "리프컷"),
            HairModel(imageName: "apply8", title: "히피펌"),

        ]
    }
}
