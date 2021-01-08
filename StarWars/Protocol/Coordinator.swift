//
//  Coordinator.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 08/01/21.
//

import Foundation

protocol Coordinator {
    var coordinators: [Coordinator] { get set }
    func start()
}
