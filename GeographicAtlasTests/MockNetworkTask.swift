//
//  MockNetworkTask.swift
//  GeographicAtlasTests
//
//  Created by Amanzhan Zharkynuly on 17.05.2023.
//

import Foundation
import UIKit
@testable import GeographicAtlas

class MockNetworkTask: NetworkTaskProtocol {
    
    var getAllCountriesCalled = false
    var getCountryByCodeCalled = false
    var getImageURL: URL?
    
    func getAllCountries(completion: @escaping (Result<[CountriesList], Error>) -> Void) {
        getAllCountriesCalled = true
    }
    
    func getCountry(ccaTwo: String, completion: @escaping (Result<[Country], Error>) -> Void) {
        getCountryByCodeCalled = true
    }
    
    func getImage(from url: URL?, completion: @escaping (Result<UIImage, Error>) -> Void) {
        getImageURL = url
    }
    
}
