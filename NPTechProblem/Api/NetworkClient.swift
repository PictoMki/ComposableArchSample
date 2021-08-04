//
//  NetworkClient.swift
//  NPTechProblem
//
//  Created by 井上知貴 on 2021/08/04.
//

import Alamofire
import ComposableArchitecture
import Foundation

class NetworkClient {
    let env: EnvDef
    init() {
        do {
            env = try AppEnv.env()
            baseURL = env.getServerURL()
            headers = ["Accept": "application/json"]
        } catch {
            fatalError("env is not exist")
        }
    }
    private let successRange = 200 ..< 300
    private var baseURL: String = ""
    private var headers: HTTPHeaders = []
    public func setHeader(headers: HTTPHeaders) {
        self.headers = headers
    }
    
    private func getUrl(path: String) -> URL {
        return URL(string: baseURL + path)!
    }
    
    private func printLog(_ url: URL, _ method: HTTPMethod, _ parameters: Parameters?, _ response: AFDataResponse<Any>) {
        #if DEBUG
        print("************** REQUEST **************")
        print("url: \(url)")
        print("method: \(method)")
        if let parameters = parameters {
            print("parameters: \(parameters)")
        }
        switch response.result {
        case let .success(data):
            print("success response: \(data)")
        case let .failure(error):
            print("error response: \(error)")
        }
        print("*************************************")
        #endif
    }
    
    public func publish<T: Codable>(_ path: String, method: HTTPMethod, parameters: Parameters?) -> Effect<T, ApiError> {
        return Effect.future { callback in
            let url = self.getUrl(path: path)
            let encoding: ParameterEncoding = (method == HTTPMethod.post || method == HTTPMethod.patch) ? JSONEncoding.default : URLEncoding.default
            let api = AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: self.headers)
                .validate(statusCode: self.successRange)
                .responseJSON { response in
                    self.printLog(url, method, parameters, response)
                    switch response.result {
                    case .success:
                        do {
                            if let data = response.data {
                                let model = try JSONDecoder().decode(T.self, from: data)
                                callback(.success(model))
                            } else {
                                callback(.failure(ApiError.noContent(error: "jsonが空です")))
                            }
                        } catch let error {
                            callback(.failure(ApiError.invalidMapping(error: error.localizedDescription)))
                        }
                    case let .failure(error):
                        callback(.failure(ApiError.unauthorized(error: error.errorDescription ?? "")))
                        break
                    }
                    
                }
            api.resume()
        }
    }
}
