//
//  CountriesList.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 13.05.2023.
//

import Foundation

protocol CurrencyProtocol: Decodable {
    var name: String? { get }
    var symbol: String? { get }
}

struct CountriesList: Decodable {
    let name: Name
    let ccaTwo: String
    let currency: [String: Currency]?
    let capital: [String]?
    let population: Int
    let area: Double
    let flag: Flag
    let continent: [Continents]
    
    enum Continents: String, Decodable, CaseIterable {
        case europe = "Europe"
        case asia = "Asia"
        case africa = "Africa"
        case oceania = "Oceania"
        case northAmerica = "North America"
        case southAmerica = "South America"
        case antarctica = "Antarctica"
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
        currency = (try? values.decode([String: Currency].self, forKey: .currency)) ?? nil
        capital = (try? values.decode([String].self, forKey: .capital)) ?? []
        population = try values.decode(Int.self, forKey: .population)
        area = try values.decode(Double.self, forKey: .area)
        flag = try values.decode(Flag.self, forKey: .flag)
        continent = try values.decode([Continents].self, forKey: .continent)
    }
}

