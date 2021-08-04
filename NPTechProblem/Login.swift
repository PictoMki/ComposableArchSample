//
//  Login.swift
//  NPTechProblem
//
//  Created by 井上知貴 on 2021/08/04.
//

import ComposableArchitecture

struct LoginState: Equatable {
    var emailText: String = ""
    var passwordText: String = ""
}

enum LoginAction: Equatable {
    case emailTextFieldInputed(String)
    case passwordTextFieldInputed(String)
    case loginButtonTapped
    case loginResponse(Result<String, LoginError>)
}
    
enum LoginError: Error, Equatable {
    case emailInValid
    case passwordInValid
    case apiError
    case unKnown
    
    var errorAlertTitle: String {
        switch self {
        case .emailInValid, .passwordInValid:
            return "入力エラー"
        case .apiError, .unKnown:
            return "通信エラー"
        }
    }
    
    var errorAlertDescription: String {
        switch self {
        case .emailInValid:
            return "メールアドレスの形式が不正です。"
        case .passwordInValid:
            return "パスワードは英数字6文字以上入力してください。"
        case .apiError:
            return "メールアドレスかパスワードが正しくありません。"
        case .unKnown:
            return "エラーが起きました。しばらくしてから再度お試しください"
        }
    }
    
    static func convertLoginError(error: ApiError) -> LoginError {
        switch error {
        case .unauthorized:
            return .apiError
        case .unKnown:
            return .unKnown
        }
    }
}

struct LoginEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var login: (String,String) -> Effect<String, LoginError>
}

let loginReducer = Reducer<LoginState, LoginAction, LoginEnvironment> { state, action, environment in
    switch action {
    case let .emailTextFieldInputed(inputText):
        state.emailText = inputText
        return .none
        
    case let .passwordTextFieldInputed(inputText):
        state.passwordText = inputText
        return .none
        
    case .loginButtonTapped:
        return environment.login(state.emailText, state.passwordText)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(LoginAction.loginResponse)
        
    case let .loginResponse(.success(accessToken)):
        KeychainService.shared.set(ref: .accessToken, value: accessToken)
        return .none
    
    case let .loginResponse(.failure(error)):
        CommonAlertService.shared.showCommonErrorAlert(
            title: error.errorAlertTitle,
            message: error.errorAlertDescription
        )
        return .none
    }
}
