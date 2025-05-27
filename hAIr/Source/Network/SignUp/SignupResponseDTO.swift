//
//  SignupResponseDTO.swift
//  hAIr
//
//  Created by 소민준 on 5/28/25.
//



import Foundation

struct SignupResponseDTO: Codable {
    let message: String
    let data: SignupData
}

struct SignupData: Codable {
    let uuid: String
    let nickname: String
    let facetype: String
    let sex: String
    let representPhotoURL: String
    let token: String
}
