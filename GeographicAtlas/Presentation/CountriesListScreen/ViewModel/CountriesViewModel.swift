//
//  CountriesViewModel.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 13.05.2023.
//

import Foundation

protocol CountriesViewModelProtocol {
    
    init(repository: Repository)
    
    var didSelectedCountry: ((SelectedModel) -> Void)? { get set }
    
    func countrySelected(_ model: SelectedModel)
}

class CountriesViewModel: CountriesViewModelProtocol {
    
    // MARK: - Properties
    
    private let repository: Repository
    private var selectedIndexPaths: [IndexPath] = []
    
    // MARK: - Initialization
    
    required init(repository: Repository) {
        self.repository = repository
    }
    
    var didSelectedCountry: ((SelectedModel) -> Void)?
    
}

// MARK: - Public Methods

extension CountriesViewModel {

    func countrySelected(_ model: SelectedModel) {
        var newModel: SelectedModel
        switch model {
        case .selected(let mod):
            newModel = .unSelected(mod)
        case .unSelected(let mod):
            newModel = .selected(mod)
        }
        didSelectedCountry?(newModel)
    }
}
