//
//  ApiResponse.swift
//  hAIr
//
//  Created by 소민준 on 5/11/25.
//



import Foundation

// 최상위 응답 모델
public struct ApiResponse<T: Decodable>: Decodable {
    public let isSuccess: Bool
    public let code: String
    public let message: String
    public let result: T?
}

public struct EmptyResponse: Decodable {}

public struct ErrorResponse: Codable {
    public let message: String
}
