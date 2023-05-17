//
//  GeographicAtlasTests.swift
//  GeographicAtlasTests
//
//  Created by Amanzhan Zharkynuly on 17.05.2023.
//

import XCTest
@testable import GeographicAtlas

class CountriesViewModelTest: XCTestCase {
    
    var viewModel: CountriesViewModelProtocol!
    var mockRepository: MockRepository!
    var mockNetworkTask: MockNetworkTask!

    override func setUpWithError() throws {
        mockNetworkTask = MockNetworkTask()
        mockRepository = MockRepository(networkTask: mockNetworkTask)
        viewModel = CountriesViewModel(repository: mockRepository)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockRepository = nil
    }
    
    func testReloadImage() {
        // Given
        let url = URL(string: "https:")!
        let indexPath = IndexPath(row: 0, section: 0)
        
        // When
        viewModel.reloadImage(with: url, indexPath: indexPath)
        
        // Then
        XCTAssertEqual(mockNetworkTask.getImageURL, url)
    }
    
    func testGetDataFromNetwork() {
        // Given
        mockNetworkTask.getAllCountriesCalled = false
        
        //When
        
        viewModel.reloadData()
        
        // Then
        XCTAssertTrue(mockNetworkTask.getAllCountriesCalled)
    }

    
}
