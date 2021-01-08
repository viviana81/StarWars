//
//  HomeCoordinator.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 08/01/21.
//

import UIKit

class HomeCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    var window: UIWindow
    let navigation: UINavigationController
    let homeViewController: HomeViewController
    
    init(window: UIWindow) {
        self.window = window
        homeViewController = HomeViewController()
        self.navigation = UINavigationController(rootViewController: homeViewController)
    }
    
    func start() {
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}
