//
//  CommonApiService.swift
//  NPTechProblem
//
//  Created by 井上知貴 on 2021/08/04.
//

import Foundation
import Alamofire

enum ApiError: Error, Equatable {
    case unauthorized(error: String)
    case noContent(error: String)
    case invalidMapping(error: String)
    case unKnown(error: String)
}

final class CommonApiService {
    var networkClient = NetworkClient()
    static let shared = CommonApiService()
    public func setAccessToken(accessToken: String) {
        let headers: HTTPHeaders = ["Accept": "application/json",
                                    "X-Api-Key": accessToken]
        networkClient.setHeader(headers: headers)
    }
}
