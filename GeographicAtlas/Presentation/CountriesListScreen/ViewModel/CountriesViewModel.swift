//
//  CountriesViewModel.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 13.05.2023.
//

import Foundation
import UIKit

protocol CountriesViewModelProtocol {
    
    init(repository: Repository)
    
    var countries: [[CountriesListData]]? { get set }
    var didRecieveData: (([[CountriesListData]]?) -> Void)? { get set }
    var didRecieveImage: ((UIImage, IndexPath) -> Void)? { get set }
    
    func reloadData()
    func reloadImage(with url: URL, indexPath: IndexPath)
}

class CountriesViewModel: CountriesViewModelProtocol {
    
    // MARK: - Properties
    
    private let repository: Repository
    var countries: [[CountriesListData]]?
    
    var didRecieveData: (([[CountriesListData]]?) -> Void)?
    var didRecieveImage: ((UIImage, IndexPath) -> Void)?
    
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
    
    func reloadImage(with url: URL, indexPath: IndexPath) {
        getImageFromNetwork(url, indexPath)
    }
}

// MARK: - Private Methods

private extension CountriesViewModel {
    
    func getDataFromNetwork() {
        repository.networkTask?.getAllCountries(completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let countriesList):
                    self.countries = self.repository.countriesListDataToSections(countriesList)
                    self.didRecieveData?(self.countries)
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
    
    func getImageFromNetwork(_ url: URL?, _ indexPath: IndexPath) {
        repository.networkTask?.getImage(from: url, completion: { result in
            switch result {
            case .success(let image):
                self.didRecieveImage?(image, indexPath)
            case .failure(let error):
                print(error)
            }
        })
    }
}

