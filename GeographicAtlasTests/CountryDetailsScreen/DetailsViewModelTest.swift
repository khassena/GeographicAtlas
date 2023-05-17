//
//  DetailsViewModelTest.swift
//  GeographicAtlasTests
//
//  Created by Amanzhan Zharkynuly on 18.05.2023.
//

import XCTest

@testable import GeographicAtlas

class DetailsViewModelTest: XCTestCase {

    var viewModel: DetailsViewModelProtocol!
    var mockRepository: MockRepository!
    var mockNetworkTask: MockNetworkTask!
    
    override func setUpWithError() throws {
        mockNetworkTask = MockNetworkTask()
        mockRepository = MockRepository(networkTask: mockNetworkTask)
        let mockCcaTwoCode = "kz"
        viewModel = DetailsViewModel(repository: mockRepository, ccaTwoCode: mockCcaTwoCode)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        mockRepository = nil
        mockNetworkTask = nil
    }

    func testReloadImage() {
        // Given
        let url = URL(string: "https:")!
        
        // When
        viewModel.reloadImage(with: url)
        
        // Then
        XCTAssertEqual(mockNetworkTask.getImageURL, url)
    }
    
    func testGetDataFromNetwork() {
        // Given
        mockNetworkTask.getCountryByCodeCalled = false
        
        //When
        viewModel.reloadData()
        
        // Then
        XCTAssertTrue(mockNetworkTask.getCountryByCodeCalled)
    }
}
