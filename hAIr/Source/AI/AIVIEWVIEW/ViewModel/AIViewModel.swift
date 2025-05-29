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
        print("📡 추천 이미지 URL:", photoURL)

        guard let url = URL(string: photoURL) else {
            print("❌ URL 생성 실패")
            completion()
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                print("📥 응답 코드:", httpResponse.statusCode)
            }
            print("📦 받은 데이터 크기:", data?.count ?? -1)

            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.selectedImage = image
                    print("✅ 이미지 변환 성공 → selectedImage에 저장 완료")
                    completion()
                }
            } else {
                print("❌ 이미지 다운로드 또는 변환 실패:", error?.localizedDescription ?? "unknown")
                DispatchQueue.main.async {
                    completion()
                }
            }
        }.resume()
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

    
