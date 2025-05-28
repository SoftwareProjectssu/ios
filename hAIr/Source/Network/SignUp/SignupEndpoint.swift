//
//  SignupEndpoint.swift
//  hAIr
//
//  Created by 소민준 on 5/28/25.
//


import Foundation
import Moya

enum SignupEndpoint {
    case signup(data: SignupRequestDTO, imageData: Data)
}

extension SignupEndpoint: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "http://3.34.130.175:3532") else {
            fatalError("❌ 잘못된 baseURL입니다.")
        }
        return url
    }

    var path: String {
        switch self {
        case .signup:
            return "/account/register"
        }
    }

    var method: Moya.Method {
        switch self {
        case .signup:
            return .post
        }
    }

    var task: Task {
        switch self {
        case .signup(let data, let imageData):
            var parts: [MultipartFormData] = []

            // Text fields
            parts.append(MultipartFormData(provider: .data(data.accessToken.data(using: .utf8)!), name: "accessToken"))
            parts.append(MultipartFormData(provider: .data(data.nickname.data(using: .utf8)!),   name: "nickname"))
            parts.append(MultipartFormData(provider: .data(data.faceType.data(using: .utf8)!),   name: "faceType"))
            parts.append(MultipartFormData(provider: .data(data.sex.data(using: .utf8)!),        name: "sex"))

            // Image
            parts.append(MultipartFormData(
                provider: .data(imageData),
                name: "photo",
                fileName: "profile.jpg",
                mimeType: "image/jpeg"
            ))

            return .uploadMultipart(parts)
        }
    }

    var headers: [String : String]? {
        return nil
    }

    var sampleData: Data {
        return Data()
    }

    var validationType: ValidationType {
        return .successCodes
    }
}
