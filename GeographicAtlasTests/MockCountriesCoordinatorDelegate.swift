//
//  MockCountriesCoordinatorDelegate.swift
//  GeographicAtlasTests
//
//  Created by Amanzhan Zharkynuly on 17.05.2023.
//

import Foundation

@testable import GeographicAtlas

class MockCountriesCoordinatorDelegate: CountriesViewModelCoordinatorDelegate {
    
    var ccaTwoCode: String?
    
    func didTapLearnMoreButton(ccaTwoCode: String) {
        self.ccaTwoCode = ccaTwoCode
    }

}
