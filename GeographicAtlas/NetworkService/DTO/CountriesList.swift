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
    let currencies: Currencies?
    let capital: [String]?
    let population: Int
    let area: Double
    let flags: Flags
    let continents: [String]
    
    struct Name: Decodable {
        let common: String
    }
    
    struct Currencies: Codable {
        let name: String?
        let symbol: String?
    }
    
    struct Flags: Decodable {
        let png: String
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case ccaTwo = "cca2"
        case currencies
        case capital
        case population
        case area
        case flags
        case continents
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(Name.self, forKey: .name)
        ccaTwo = try values.decode(String.self, forKey: .ccaTwo)
        currencies = (try? values.decode(Currencies.self, forKey: .currencies)) ?? nil
        capital = (try? values.decode([String].self, forKey: .capital)) ?? []
        population = try values.decode(Int.self, forKey: .population)
        area = try values.decode(Double.self, forKey: .area)
        flags = try values.decode(Flags.self, forKey: .flags)
        continents = try values.decode([String].self, forKey: .continents)
    }
}
