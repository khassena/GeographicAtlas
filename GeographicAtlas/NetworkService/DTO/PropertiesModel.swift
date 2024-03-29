//
//  PropertiesModel.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 17.05.2023.
//

import Foundation

struct Name: Decodable {
    let common: String
}

struct Flag: Decodable {
    let png: String
}

struct Currency: Decodable {
    let name: String?
    let symbol: String?
}

struct Maps: Codable {
    let openStreetMaps: String?
}

