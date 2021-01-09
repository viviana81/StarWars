//
//  MockServices.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 09/01/21.
//

import Foundation
import Moya

struct ApiServices: Services {
    
    let provider = MoyaProvider<StarWarsApi>()
    let decoder: JSONDecoder
    
    init() {
        decoder = JSONDecoder()
    }
    
    func getPeople(completion: @escaping (PaginatedResponse<People>?, Error?) -> Void) {
        provider.request(.getPeople) { result in
            switch result {
            case .success(let response):
                let pagResponse = try? decoder.decode(PaginatedResponse<People>.self, from: response.data)
                completion(pagResponse, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}

// TODO: - Move away
struct PaginatedResponse<T: Decodable>: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [T]
}
