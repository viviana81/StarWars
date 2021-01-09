//
//  AppCoordinator.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 08/01/21.
//

import UIKit

class AppCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    var window: UIWindow
    let services: Services
    
    init(window: UIWindow, services: Services) {
        self.window = window
        self.services = services
    }
    
    func start() {
        coordinators.removeAll()
        
        let homeCoordinator = HomeCoordinator(window: window, services: services)
        coordinators.append(homeCoordinator)
        homeCoordinator.start()
    }
}
