//
//  HomeCoordinator.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 08/01/21.
//

import UIKit
import PromiseKit

class HomeCoordinator: Coordinator {
    var coordinators: [Coordinator] = []
    var window: UIWindow
    let navigation: UINavigationController
    let homeViewController: HomeViewController
    let services: Services
    var nextPage: Int?
    var detail: DetailViewController?
    
    init(window: UIWindow, services: Services) {
        self.window = window
        self.services = services
        homeViewController = HomeViewController()
        self.navigation = BlackNavigationController(rootViewController: homeViewController)
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
                self?.homeViewController.showAlert(andMessage: error.localizedDescription)
            }
        }
    }
    
    func onCellTap(star: People) {
        detail = DetailViewController(star: star)
        detail!.delegate = self
        navigation.pushViewController(detail!, animated: true)
    }
}
extension HomeCoordinator: DetailViewControllerDelegate {
    
    func onFilmCellTap(film: Film) {
        let filmDetail = FilmDetailViewController(film: film)
        navigation.pushViewController(filmDetail, animated: true)
    }
    
    func getData(star: People) {
        
        guard let detail = detail else { return }
        
        // recupero tutti gli id degli url dei film
        let filmIds = star.films.compactMap { (filmString) -> String? in
            guard let idUrl = URL(string: filmString) else { return nil }
            return idUrl.lastPathComponent
        }
        
        // recupero tutti gli id degli url dei veicoli
        let vehicleIds = star.vehicles.compactMap { (vehicleString) -> String? in
            guard let idUrl = URL(string: vehicleString) else { return nil }
            return idUrl.lastPathComponent
        }
       
        // array di promise di film e veicoli
        let filmPromises = filmIds.map { getFilm(id: $0) }
        let vehiclePromises = vehicleIds.map { getVehicle(id: $0) }
        
        firstly {
            when(fulfilled: filmPromises)
        }.then { films -> Promise<[Vehicle]> in
            detail.status = .filmLoaded(films: films)
            return when(fulfilled: vehiclePromises)
        }.done { vehicles in
            detail.status = .vehicleLoaded(vehicles: vehicles)
        }.catch { error in
            detail.status = .error(error: error)
        }
    }
    
    func getFilm(id: String) -> Promise<Film> {
        
        return Promise<Film> { seal in
            
            services.getFilm(id: id) { (film, error) in
                if let film = film {
                    seal.fulfill(film)
                } else if let error = error {
                    seal.reject(error)
                }
            }
        }
    }
    
    func getVehicle(id: String) -> Promise<Vehicle> {
        
        return Promise<Vehicle> { seal in
            
            services.getVehicle(id: id) { (vehicle, error) in
                if let vehicle = vehicle {
                    seal.fulfill(vehicle)
                } else if let error = error {
                    seal.reject(error)
                }
            }
            
        }
    }
}
