//
//  CountriesViewModel.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 13.05.2023.
//

import Foundation

protocol CountriesViewModelProtocol {
    
    init(repository: Repository)
    
    var countries: [CountriesListForCell]? { get set }
    var didRecieveData: (([CountriesListForCell]) -> Void)? { get set }
    
    func reloadData()
}

class CountriesViewModel: CountriesViewModelProtocol {
    
    // MARK: - Properties
    
    private let repository: Repository
    var countries: [CountriesListForCell]?
    
    var didRecieveData: (([CountriesListForCell]) -> Void)?
    
    // MARK: - Initialization
    
    required init(repository: Repository) {
        self.repository = repository
        DispatchQueue.main.async {
            self.reloadData()
        }
    }

    
}

// MARK: - Public Methods

extension CountriesViewModel {
    
    func reloadData() {
        getDataFromNetwork()
    }
}

// MARK: - Private Methods

private extension CountriesViewModel {
    
    func getDataFromNetwork() {
        repository.networkTask?.getAllCountries(completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let countriesList):
                    self.countries = countriesList.compactMap {
                        return self.repository.countriesListElementToCell($0)
                    }
                    self.didRecieveData?(self.countries ?? [])
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
}

