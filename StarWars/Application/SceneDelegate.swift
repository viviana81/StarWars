//
//  SceneDelegate.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 08/01/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        window.tintColor = .white
        let services = ApiServices()
        let appCoordinator = AppCoordinator(window: window, services: services)
        appCoordinator.start()
        
        self.coordinator = appCoordinator
        self.window = window
        
        window.makeKeyAndVisible()
        
    }
}
