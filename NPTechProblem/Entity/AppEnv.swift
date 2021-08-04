//
//  AppEnv.swift
//  NPTechProblem
//
//  Created by 井上知貴 on 2021/08/04.
//

import Foundation

enum EnvError: Error {
    case envNotSet
}
enum AppEnv {
    #if PRODUCTION
    private static let _appEnv = EnvDef.production
    #elseif STAGING
    private static let _appEnv = EnvDef.staging
    #else
    private static let _appEnv = EnvDef.development
    #endif
    
    static func env() throws -> EnvDef {
        if AppEnv._appEnv.rawValue == "" {
            throw EnvError.envNotSet
        }
        return AppEnv._appEnv
    }
    static func isDevelopment() -> Bool {
        return AppEnv._appEnv == EnvDef.development
    }
    static func isStaging() -> Bool {
        return AppEnv._appEnv == EnvDef.staging
    }
    static func isProduction() -> Bool {
        return AppEnv._appEnv == EnvDef.production
    }
}

enum EnvDef: String {
    case development
    case staging
    case production
    
    func getServerURL() -> String {
        switch self {
        case .development:
            return "https://us-central1-android-technical-exam.cloudfunctions.net/"
        case .staging:
            return "https://us-central1-android-technical-exam.cloudfunctions.net/"
        case .production:
            return "https://us-central1-android-technical-exam.cloudfunctions.net/"
        }
    }
}
