//
//  KeychainService.swift
//  NPTechProblem
//
//  Created by 井上知貴 on 2021/08/04.
//

import KeychainSwift

final class KeychainService {
    static let shared = KeychainService()
    private let keychainSwift = KeychainSwift()
    
    func set(ref: KeychainRef, value: String) {
        keychainSwift.set(value, forKey: ref.rawValue)
    }
    
    func getString(ref: KeychainRef) -> String {
        guard let value = keychainSwift.get(ref.rawValue) else {
            return ""
        }
        return value
    }
}

enum KeychainRef: String {
    case accessToken
}
