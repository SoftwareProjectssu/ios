//
//  KeychainHelper.swift
//  hAIr
//
//  Created by 소민준 on 5/11/25.
//
//



import Foundation
import Security

class KeychainHelper {
    static let shared = KeychainHelper()
    
    private init() {}
    
    // Keychain에 데이터 저장
    func save(_ value: String, forKey key: String) {
        let data = value.data(using: .utf8)!

        // 먼저 기존 항목 삭제 (이 쿼리로)
        let deleteQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(deleteQuery as CFDictionary)

        // 새로운 값 추가
        let addQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]

        let status = SecItemAdd(addQuery as CFDictionary, nil)
        if status == errSecSuccess {
            print("✅ Keychain 저장 성공")
        } else {
            print("❌ Keychain 저장 실패, status: \(status)")
        }
    }
    // Keychain에서 데이터 가져오기
    func get(forKey key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        } else {
            print("❌ Keychain get 실패: \(status)") // 🔍 이 줄 추가
        }
        
        return nil
    }
    
    // Keychain에서 데이터 삭제
    func delete(forKey key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}
