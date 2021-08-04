//
//  LoginApiService.swift
//  NPTechProblem
//
//  Created by 井上知貴 on 2021/08/04.
//

import Foundation
import ComposableArchitecture

struct LoginResponse: Codable {
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
      }
}

final class LoginApiService {
    static func login(email: String, password: String) -> Effect<LoginResponse, ApiError> {
        return CommonApiService.shared.networkClient.publish("/login", method: .post, parameters: nil)
    }
}
