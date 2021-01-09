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
    let services: Services
    var nextPage: Int?
    
    init(window: UIWindow, services: Services) {
        self.window = window
        self.services = services
        homeViewController = HomeViewController()
        self.navigation = UINavigationController(rootViewController: homeViewController)
    }
    
    func start() {
        homeViewController.delegate = self
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
   
    func getPeople() {
        
        let page = nextPage
        
        services.getPeople(page: page) { [weak self] response, error in
          
            if let response = response {
                self?.nextPage = response.nextPage
                self?.homeViewController.people += response.results
            } else if let error = error {
                print(error)
                // TODO: show error
            }
        }
    }
    
    func onCellTap(star: People) {
        let detail = DetailViewController(star: star)
        navigation.pushViewController(detail, animated: true)
    }
}
