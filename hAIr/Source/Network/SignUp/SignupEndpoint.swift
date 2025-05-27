//
//  SignupEndpoint.swift
//  hAIr
//
//  Created by 소민준 on 5/28/25.
//


import Foundation
import Moya

enum SignupEndpoint {
    case signup(data: SignupRequestDTO)
}

extension SignupEndpoint: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://3.34.130.175:3532") else {
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
        case .signup(let data):
            return .requestJSONEncodable(data)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        return Data()
    }

    var validationType: ValidationType {
        return .successCodes
    }
}
