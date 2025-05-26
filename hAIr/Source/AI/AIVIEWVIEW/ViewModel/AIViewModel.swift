//
//  AIViewModel.swift
//  hAIr
//
//  Created by 소민준 on 5/13/25.
//

import Foundation
import UIKit

class AIViewModel: ObservableObject {
    @Published var isImagePickerPresented = false
    @Published var showSourceActionSheet = false
    @Published var selectedImage: UIImage? = nil
    @Published var pickerSource: UIImagePickerController.SourceType = .photoLibrary

    func presentCamera() {
        pickerSource = .camera
        isImagePickerPresented = true
    }

    func presentLibrary() {
        pickerSource = .photoLibrary
        isImagePickerPresented = true
    }

    func reset() {
        selectedImage = nil
        isImagePickerPresented = false
        showSourceActionSheet = false
        pickerSource = .photoLibrary
    }
}
