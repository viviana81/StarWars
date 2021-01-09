//
//  StarWarsApi.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 08/01/21.
//

import Foundation
import Moya

enum StarWarsApi {
    case getPeople
}

extension StarWarsApi: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://swapi.dev/api/")!
    }
    
    var path: String {
        switch self {
        case .getPeople:
            return "people"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPeople:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getPeople:
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
