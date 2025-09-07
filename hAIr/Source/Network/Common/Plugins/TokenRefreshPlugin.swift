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
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }

        return request
    }
}

