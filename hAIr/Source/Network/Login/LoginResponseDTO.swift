//
//  LoginResponseDTO.swift
//  hAIr
//
//  Created by 소민준 on 5/28/25.
//

import Foundation

struct LoginResponseDTO: Decodable {
    let message: String
    let data: LoginData
    
    struct LoginData: Decodable {
        let userId: String
        let nickname: String
        let token: String
    }
}
