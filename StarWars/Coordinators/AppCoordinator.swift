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
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        coordinators.removeAll()
        
        let homeCoordinator = HomeCoordinator(window: window)
        coordinators.append(homeCoordinator)
        homeCoordinator.start()
    }
}
