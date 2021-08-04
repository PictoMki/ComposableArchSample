//
//  RouteState.swift
//  NPTechProblem
//
//  Created by 井上知貴 on 2021/08/04.
//

import Combine

class RouteState: ObservableObject {
  @Published var appRoute: Route = .splash
  @Published var routeHistory: [Route] = [.splash]
    
    func moveToView(route: Route) {
        routeHistory.append(appRoute)
        appRoute = route
    }

    func moveToBack() {
        appRoute = routeHistory.last ?? .splash
        routeHistory.removeLast()
    }

    func popUntil(route: Route) {
        guard let untilIndex = routeHistory.firstIndex(of: route) else {
          return
        }
        appRoute = routeHistory[untilIndex]
        let lastIndex = routeHistory.endIndex
        routeHistory.removeSubrange(untilIndex..<lastIndex)
    }
}
