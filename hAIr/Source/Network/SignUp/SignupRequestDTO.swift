//
//  SignupRequestDTO.swift
//  hAIr
//
//  Created by 소민준 on 5/28/25.
//


struct SignupRequestDTO: Codable {
    let accessToken: String
    let nickname: String
    let faceType: String
    let sex: String
}
