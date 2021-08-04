//
//  NPTechProblemApp.swift
//  NPTechProblem
//
//  Created by 井上知貴 on 2021/08/04.
//

import SwiftUI

@main
struct NPTechProblemApp: App {
    var body: some Scene {
        WindowGroup {
            RouteView()
                .environmentObject(RouteState())
                .environmentObject(AlertState())
        }
    }
}
