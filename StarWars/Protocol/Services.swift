//
//  Services.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 08/01/21.
//

import Foundation

protocol Services {
    
    func getPeople(page: Int?, completion: @escaping (PaginatedResponse<People>?, Error?) -> Void)
    
    func getFilm(id: String, completion: @escaping (Film?, Error?) -> Void)
    func getVehicle(id: String, completion: @escaping (Vehicle?, Error?) -> Void)
}
