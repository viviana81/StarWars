//
//  Services.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 08/01/21.
//

import Foundation

protocol Services {
    
    func getPeople(completion: @escaping (PaginatedResponse<People>?, Error?) -> Void)
}
