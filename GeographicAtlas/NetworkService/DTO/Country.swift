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
    let subRegion: [String]?
    let coordinates: [Double]
    let timeZones: [String]
    let currency: Currency?
    let capital: [String]?
    let population: Int
    let area: Int
    let flag: Flag
    
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
        case subRegion = "subregion"
        case coordinates = "latlng"
        case timeZones = "timezones"
        case currency = "currencies"
        case capital
        case population
        case area
        case flag = "flags"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(Name.self, forKey: .name)
        ccaTwo = try values.decode(String.self, forKey: .ccaTwo)
        subRegion = (try? values.decode([String].self, forKey: .subRegion)) ?? []
        coordinates = try values.decode([Double].self, forKey: .coordinates)
        timeZones = try values.decode([String].self, forKey: .timeZones)
        currency = (try? values.decode(Currency.self, forKey: .currency)) ?? nil
        capital = (try? values.decode([String].self, forKey: .capital)) ?? []
        population = try values.decode(Int.self, forKey: .population)
        area = try values.decode(Int.self, forKey: .area)
        flag = try values.decode(Flag.self, forKey: .flag)
    }
}

