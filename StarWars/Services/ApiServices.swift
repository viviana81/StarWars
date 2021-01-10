//
//  MockServices.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 09/01/21.
//

import Foundation
import Moya

struct ApiServices: Services {
    
    let provider = MoyaProvider<StarWarsApi>(plugins: [NetworkLoggerPlugin(verbose: false, cURL: true)])
    
    let decoder: JSONDecoder
    
    init() {
        decoder = JSONDecoder()
    }
    
    func getPeople(page: Int?, completion: @escaping (PaginatedResponse<People>?, Error?) -> Void) {
        provider.request(.getPeople(page: page)) { result in
            switch result {
            case .success(let response):
                let pagResponse = try? decoder.decode(PaginatedResponse<People>.self, from: response.data)
                completion(pagResponse, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    func getFilm(id: String, completion: @escaping (Film?, Error?) -> Void) {
        provider.request(.getFilm(id: id)) { result in
            switch result {
            case .success(let response):
                let film = try? decoder.decode(Film.self, from: response.data)
                completion(film, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getVehicle(id: String, completion: @escaping (Vehicle?, Error?) -> Void) {
        provider.request(.getVehicle(id: id)) { result in
            switch result {
            case .success(let response):
                let film = try? decoder.decode(Vehicle.self, from: response.data)
                completion(film, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
