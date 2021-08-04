//
//  AlertState.swift
//  NPTechProblem
//
//  Created by 井上知貴 on 2021/08/04.
//

import SwiftUI

class AlertState: ObservableObject {
    @Published private(set) var alertItem: AlertItem?
    @Published var showAlert: Bool = false
    func setAlert(item: AlertItem) {
        DispatchQueue.main.async {
            self.alertItem = item
            self.showAlert = true
        }
    }
    func dismissAlert() {
        DispatchQueue.main.async {
            self.alertItem = nil
            self.showAlert = false
        }
    }
}

class AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    init(title: Text = Text(""), message: Text = Text("")) {
        self.title = title
        self.message = message
    }
    init(title: String = "", message: String = "") {
        self.title = Text(title)
        self.message = Text(message)
    }
}
class SingleButtonAlertItem: AlertItem {
    let dismissButton: Alert.Button
    init(title: Text = Text(""), message: Text = Text(""), dismissButton: Alert.Button) {
        self.dismissButton = dismissButton
        super.init(title: title, message: message)
    }
    init(title: String = "", message: String = "", dismissButton: Alert.Button) {
        self.dismissButton = dismissButton
        super.init(title: title, message: message)
    }
}
class DoubleButtonAlertItem: AlertItem {
    let primaryButton: Alert.Button
    let secondaryButton: Alert.Button
    init(title: Text = Text(""), message: Text = Text(""), primaryButton: Alert.Button, secondaryButton: Alert.Button) {
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
        super.init(title: title, message: message)
    }
    init(title: String = "", message: String = "", primaryButton: Alert.Button, secondaryButton: Alert.Button) {
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
        super.init(title: title, message: message)
    }
}
