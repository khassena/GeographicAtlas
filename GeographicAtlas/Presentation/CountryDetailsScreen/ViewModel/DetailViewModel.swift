//
//  DetailViewModel.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 16.05.2023.
//

import Foundation

protocol DetailsViewModelProtocol {
    init(repository: RepositoryProtocol)
}

protocol ViewModelCoordinatorDelegate {
    func viewWillDisappear()
    func didTapLearnMore(ccaTwoCode: String)
}

class DetailsViewModel: DetailsViewModelProtocol {
    
    // MARK: - Properties
    
    private let repository: RepositoryProtocol
    
    required init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    
    
}
