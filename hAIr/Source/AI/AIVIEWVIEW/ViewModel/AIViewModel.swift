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
    @Published var selectedFileName: String? = nil
    @Published var resultPhotoURL: String? = nil
    

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
    
    func handlePhotoUploadResult(_ photoURL: String, completion: @escaping () -> Void) {
        self.resultPhotoURL = photoURL
        completion()
    }
    
    func sendImageToServer(request: PhotoRecommendRequestDTO, completion: @escaping () -> Void) {
        PhotoService.shared.sendPhotoForRecommendation(
            imageData: request.imageData,
            fileName: request.fileName
            
        ) { result in
            switch result {
            case .success(let response):
                print("✅ 업로드 성공:", response.photoURL)
                self.handlePhotoUploadResult(response.photoURL, completion: completion)
            case .failure(let error):
                print("❌ 업로드 실패:", error.localizedDescription)
            }
        }
    }

}

    
