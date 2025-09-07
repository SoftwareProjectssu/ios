// MyhairViewModel.swift
// hAIr

import SwiftUI


final class SavedHairViewModel: ObservableObject {
    @Published var items: [HairModel]

    init() {
        self.items = [
            HairModel(imageName: "trend1", title: "가르마펌"),
            HairModel(imageName: "trend2", title: "가일컷"),
            HairModel(imageName: "trend3", title: "리프컷"),
            HairModel(imageName: "trend4", title: "히피펌"),
            HairModel(imageName: "trend5", title: "가르마펌"),
            HairModel(imageName: "trend6", title: "가일컷"),
            HairModel(imageName: "trend7", title: "리프컷"),
            HairModel(imageName: "trend8", title: "히피펌"),
            HairModel(imageName: "trend9", title: "히피펌"),
            
        ]
    }
}
