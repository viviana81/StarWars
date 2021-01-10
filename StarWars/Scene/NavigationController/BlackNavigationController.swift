//
//  BlackNavigationController.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 10/01/21.
//

import UIKit

class BlackNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        navigationBar.barTintColor = .black
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white,
                                             .font: UIFont.jediFont(ofSize: 18)!]
    
    }
}
