//
//  CountriesList.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 13.05.2023.
//

import Foundation

struct CountriesList: Decodable {
    let name: Name
    let ccaTwo: String
    let currency: Currency?
    let capital: [String]?
    let population: Int
    let area: Double
    let flag: Flag
    let continent: [String]
    
    struct Name: Decodable {
        let common: String
    }
    
    struct Currency: Codable {
        let name: String?
        let symbol: String?
    }
    
    struct Flag: Decodable {
        let png: String
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case ccaTwo = "cca2"
        case currency = "currencies"
        case capital
        case population
        case area
        case flag = "flags"
        case continent = "continents"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(Name.self, forKey: .name)
        ccaTwo = try values.decode(String.self, forKey: .ccaTwo)
        currency = (try? values.decode(Currency.self, forKey: .currency)) ?? nil
        capital = (try? values.decode([String].self, forKey: .capital)) ?? []
        population = try values.decode(Int.self, forKey: .population)
        area = try values.decode(Double.self, forKey: .area)
        flag = try values.decode(Flag.self, forKey: .flag)
        continent = try values.decode([String].self, forKey: .continent)
    }
}
