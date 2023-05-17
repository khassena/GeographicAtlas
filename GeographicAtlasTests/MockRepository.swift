//
//  MockRepository.swift
//  GeographicAtlasTests
//
//  Created by Amanzhan Zharkynuly on 17.05.2023.
//

import Foundation
@testable import GeographicAtlas

class MockRepository: RepositoryProtocol {
    
    var networkTask: NetworkTaskProtocol?
    
    required init(networkTask: NetworkTaskProtocol) {
        self.networkTask = networkTask
    }
    
    func countriesListDataToSections(_ countriesList: [CountriesList]) -> [[CountriesListData]]? {
        return [[CountriesListData(countryName: "12", capitalCity: "", flagUrl: "12", population: "12", area: "12", currency: "12", continent: [CountriesList.Continents.europe] , ccaTwoCode: "12")]]
    }
    
    func countriesListElementToCell(_ countriesList: CountriesList) -> CountriesListData {
        return CountriesListData(countryName: "qw", capitalCity: "qw", flagUrl: "", population: "qw", area: "qw", currency: "qw", continent: [CountriesList.Continents.europe], ccaTwoCode: "we")
    }
    
    func countryDetailDataToTransfer(_ countryDetail: [Country]) -> ([String], (String, String, String)) {
        return ([""], ("", "", ""))
    }

}
