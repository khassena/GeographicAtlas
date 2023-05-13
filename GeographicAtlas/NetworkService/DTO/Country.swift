//
//  Countries.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 13.05.2023.
//

import Foundation

struct Country: Decodable {
    let name: Name
    let ccaTwo: String
    let subregion: [String]?
    let coordinates: [Double]
    let timezones: [String]
    let currencies: Currencies?
    let capital: [String]?
    let population: Int
    let area: Int
    let flags: Flags
    
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
        case subregion
        case coordinates = "latlng"
        case timezones
        case currencies
        case capital
        case population
        case area
        case flags
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(Name.self, forKey: .name)
        ccaTwo = try values.decode(String.self, forKey: .ccaTwo)
        subregion = (try? values.decode([String].self, forKey: .subregion)) ?? []
        coordinates = try values.decode([Double].self, forKey: .coordinates)
        timezones = try values.decode([String].self, forKey: .timezones)
        currencies = (try? values.decode(Currencies.self, forKey: .currencies)) ?? nil
        capital = (try? values.decode([String].self, forKey: .capital)) ?? []
        population = try values.decode(Int.self, forKey: .population)
        area = try values.decode(Int.self, forKey: .area)
        flags = try values.decode(Flags.self, forKey: .flags)
    }
}

