//
//  CommonAlertService.swift
//  NPTechProblem
//
//  Created by 井上知貴 on 2021/08/04.
//

import Foundation
import SwiftUI

class CommonAlertService {
    var showAlertHandler: ((AlertItem) -> Void)?
    var dismissAlertHandler: (() -> Void)?
    static let shared = CommonAlertService()
    
    func setUpHandler(showAlertHandler: @escaping (AlertItem) -> Void, dismissAlertHandler: @escaping () -> Void) {
        self.showAlertHandler = showAlertHandler
        self.dismissAlertHandler = dismissAlertHandler
    }
    
    func showAlert(alertItem: AlertItem) {
        guard let showAlertHandler = showAlertHandler else {
            return
        }
        showAlertHandler(alertItem)
    }
    
    func dismissAlert() {
        guard let dismissAlertHandler = dismissAlertHandler else {
            return
        }
        dismissAlertHandler()
    }
    
    func showCommonErrorAlert(title: String, message: String) {
        showAlert(
            alertItem: SingleButtonAlertItem(
                title: Text(title),
                message: Text(message),
                dismissButton: .default(
                    Text("閉じる"),
                    action: {
                        self.dismissAlert()
                    }
                )
            )
        )
    }
}
