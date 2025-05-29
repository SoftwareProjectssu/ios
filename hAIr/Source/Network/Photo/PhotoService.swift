//
//  PhotoService.swift
//  hAIr
//
//  Created by 소민준 on 5/28/25.
//


import Foundation
import Moya

final class PhotoService {
    static let shared = PhotoService()
    private let provider = MoyaProvider<PhotoEndpoint>(plugins: [TokenRefreshPlugin()])

    private init() {}

    // 사진 추천 요청
    func sendPhotoForRecommendation(imageData: Data, fileName: String, completion: @escaping (Result<PhotoRecommendResponseDTO, Error>) -> Void) {
        provider.request(.recommend(imageData: imageData, fileName: fileName)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(PhotoRecommendResponseDTO.self, from: response.data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // 염색 요청
    func dyePhoto(photoId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        provider.request(.dye(photoId: photoId)) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // 저장 요청
    func savePhoto(photoId: String, completion: @escaping (Result<Void, Error>) -> Void) {
        provider.request(.save(photoId: photoId)) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
