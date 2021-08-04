//
//  RouteView.swift
//  NPTechProblem
//
//  Created by 井上知貴 on 2021/08/04.
//

import SwiftUI

enum Route {
    case splash
    case login
    case main
}

struct RouteView: View {
    @EnvironmentObject var routeState: RouteState
    @EnvironmentObject var alertState: AlertState
    
    var body: some View {
        ZStack {
            switch routeState.appRoute {
            case .splash:
                EmptyView()
            case .login, .main:
                LoginView()
            }
        }
        .alert(isPresented: $alertState.showAlert) {
            if let singleButtonAlertItem = alertState.alertItem as? SingleButtonAlertItem {
                return Alert(
                    title: singleButtonAlertItem.title,
                    message: singleButtonAlertItem.message,
                    dismissButton: singleButtonAlertItem.dismissButton
                )
            } else if let doubleButtonAlertItem = alertState.alertItem as? DoubleButtonAlertItem {
                return Alert(
                    title: doubleButtonAlertItem.title,
                    message: doubleButtonAlertItem.message,
                    primaryButton: doubleButtonAlertItem.primaryButton,
                    secondaryButton: doubleButtonAlertItem.secondaryButton
                )
            } else if let alertItem = alertState.alertItem {
                return Alert(
                    title: alertItem.title,
                    message: alertItem.message
                )
            }
            return Alert(title: Text(""),
                         message: Text(""))
        }
        .onAppear {
            initialize()
        }
    }
    
    func initialize() {
        CommonAlertService.shared.setUpHandler(showAlertHandler: alertState.setAlert, dismissAlertHandler: alertState.dismissAlert)
    }
}

struct RouteView_Previews: PreviewProvider {
    static var previews: some View {
        RouteView()
    }
}
