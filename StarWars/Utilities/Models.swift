//
//  Models.swift
//  StarWars
//
//  Created by Viviana Capolvenere on 09/01/21.
//

import Foundation

enum Gender: String, Codable {
    
    case male
    case female
    case other = "n/a"
}

struct People: Codable {
    
    let name: String
    let height: String
    let mass: String
    let eyeColor: String
    let hairColor: String
    let skinColor: String
    let birth: String
    let gender: Gender
    let films: [String]
    let vehicles: [String]
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case eyeColor = "eye_color"
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case birth = "birth_year"
    
        case url, name, mass, height, films, gender, vehicles
    }
    
    var id: String? {
        
        guard let idUrl = URL(string: url) else { return nil }
        return idUrl.lastPathComponent
    }
}

struct Film: Codable {
    let title: String
    let message: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case message = "opening_crawl"
        case date = "release_date"
        case title
    }
}

struct Vehicle: Codable {
    let name: String
    let model: String
    let manufacturer: String
    let lenght: String
    let price: String
    
    enum CodingKeys: String, CodingKey {
        case price = "cost_in_credits"
        case name, model, manufacturer, lenght
    }
}
