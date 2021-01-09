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
                let pagResponse = try! decoder.decode(PaginatedResponse<People>.self, from: response.data)
                completion(pagResponse, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
