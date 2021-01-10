//
//  StarWarsApi.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 08/01/21.
//

import Foundation
import Moya

enum StarWarsApi {
    case getPeople(page: Int?)
    case getFilm(id: String)
    case getVehicle(id: String)
}

extension StarWarsApi: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://private-e2e58-starwars8.apiary-mock.com/")!
    }
    
    var path: String {
        switch self {
        case .getPeople:
            return "people/"
        case .getFilm(let id):
            return "films/\(id)"
        case .getVehicle(let id):
            return "vehicle/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPeople, .getFilm, .getVehicle:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getPeople(let page):
            
            if let page = page {
                return .requestParameters(parameters: ["page": page], encoding: URLEncoding.default)
            } else {
                return .requestPlain
            }
        case .getFilm, .getVehicle:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return [:]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
