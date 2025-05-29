//
//  TokenRefreshPlugin.swift
//  hAIr
//
//  Created by 소민준 on 5/11/25.
//



import Foundation
import Moya

final class TokenRefreshPlugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request

        if let accessToken = KeychainHelper.shared.get(forKey: "accessToken") {
            print("✅ TokenRefreshPlugin: 토큰 있음 → Authorization 헤더 추가")
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        } else {
            print("❌ TokenRefreshPlugin: accessToken 없음 → 헤더 추가 실패")
        }

        return request
    }
}

