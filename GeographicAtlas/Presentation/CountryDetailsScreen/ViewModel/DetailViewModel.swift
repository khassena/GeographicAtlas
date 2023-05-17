//
//  DetailViewModel.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 16.05.2023.
//

import UIKit

protocol DetailsViewModelProtocol {
    init(repository: RepositoryProtocol, ccaTwoCode: String)
    
    var countryProperties: [String]? { get set }
    var countryNameFlagMaps: (String, String, String)? { get set }
    
    var didRecieveData: (([String], String, String) -> Void)? { get set }
    var didRecieveImage: ((UIImage) -> Void)? { get set }
    
    func reloadData()
    func reloadImage(with url: URL)
}

protocol ViewModelCoordinatorDelegate: AnyObject {
    func viewWillDisappear()
    func didTapLearnMore(ccaTwoCode: String)
}

class DetailsViewModel: DetailsViewModelProtocol {
    
    // MARK: - Properties
    
    weak var coordinatorDelegate: ViewModelCoordinatorDelegate?
    
    private let repository: RepositoryProtocol
    private let ccaTwoCode: String
    
    var countryProperties: [String]?
    var countryNameFlagMaps: (String, String, String)?
    
    var didRecieveData: (([String], String, String) -> Void)?
    var didRecieveImage: ((UIImage) -> Void)?
    
    required init(repository: RepositoryProtocol, ccaTwoCode: String) {
        self.repository = repository
        self.ccaTwoCode = ccaTwoCode
        self.reloadData()
    }
    
    
}

// MARK: - Public Methods

extension DetailsViewModel {
    
    func reloadData() {
        getDataFromNetwork()
    }
    
    func reloadImage(with url: URL) {
        getImageFromNetwork(url)
    }
    
}

// MARK: - Private Methods

private extension DetailsViewModel {
    
    func getDataFromNetwork() {
        repository.networkTask?.getCountry(ccaTwo: ccaTwoCode, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let countryDetail):
                    (self.countryProperties, self.countryNameFlagMaps) = self.repository.countryDetailDataToTransfer(countryDetail)
                    
                    self.didRecieveData?(self.countryProperties ?? [""], self.countryNameFlagMaps?.0 ?? "", self.countryNameFlagMaps?.2 ?? "")
                    
                    guard let imageUrl = URL(string: self.countryNameFlagMaps?.1 ?? "") else { return }
                    self.reloadImage(with: imageUrl)
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
    
    func getImageFromNetwork(_ url: URL?) {
        repository.networkTask?.getImage(from: url, completion: { result in
            switch result {
            case .success(let image):
                self.didRecieveImage?(image)
            case .failure(let error):
                print(error)
            }
        })
    }
}

