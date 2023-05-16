//
//  CountriesListForCell.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 15.05.2023.
//

import Foundation

struct CountriesListData: Equatable {
    let countryName: String
    let capitalCity: String
    let flagUrl: String
    let population: String
    let area: String
    let currency: String
    let continent: [CountriesList.Continents]
}
