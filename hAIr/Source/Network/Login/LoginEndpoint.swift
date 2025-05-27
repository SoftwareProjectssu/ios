//
//  LoginEndpoint.swift
//  hAIr
//
//  Created by 소민준 on 2025/05/28.
//

import Foundation
import Moya

/// 로그인 관련 API를 정의한 enum
enum LoginEndpoint {
    case login(data: LoginRequestDTO)
}

extension LoginEndpoint: TargetType {
    
    // 기본 서버 주소
    var baseURL: URL {
        guard let url = URL(string: "https://3.34.130.175:3532") else {
            fatalError("❌ 잘못된 baseURL입니다.")
        }
        return url
    }
    
    // 각 요청별 경로
    var path: String {
        switch self {
        case .login:
            return "/account/login"
        }
    }
    
    // HTTP Method 지정
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    // 실제 보낼 파라미터 설정
    var task: Task {
        switch self {
        case .login(let data):
            return .requestJSONEncodable(data)
        }
    }
    
    // 요청 헤더
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    // 유효한 응답 코드 설정
    var validationType: ValidationType {
        return .successCodes
    }
    
    // 테스트용 샘플 데이터 (필요 없으면 그냥 빈 값)
    var sampleData: Data {
        return Data()
    }
}
