import Foundation
import Moya

enum PhotoEndpoint {
    case recommend(imageData: Data, fileName: String)
    case dye(photoId: String)
    case save(photoId: String)
}

extension PhotoEndpoint: TargetType {
    var baseURL: URL {
        return URL(string: "http://3.34.130.175:3532")!
    }

    var path: String {
        switch self {
        case .recommend:
            return "/photo/recommend"
        case .dye:
            return "/photo/dye"
        case .save:
            return "/photo/save"
        }
    }

    var method: Moya.Method {
        return .post
    }

    var task: Task {
        switch self {
        case let .recommend(imageData, fileName):
            let formData = MultipartFormData(
                provider: .data(imageData),
                name: "photo",                   // ✅ req.file.fieldname과 일치
                fileName: fileName,              // ex: "profile.jpg"
                mimeType: "image/jpeg"
            )
            return .uploadMultipart([formData])

        case let .dye(photoId), let .save(photoId):
            return .requestParameters(
                parameters: ["photoId": photoId],
                encoding: JSONEncoding.default
            )
        }
    }

    var headers: [String : String]? {
        switch self {
        case .recommend:
            return ["Content-Type": "multipart/form-data"]
        case .dye, .save:
            return ["Content-Type": "application/json"]
        }
    }

    var validationType: ValidationType {
        return .successCodes
    }

    var sampleData: Data {
        return Data()
    }
}
