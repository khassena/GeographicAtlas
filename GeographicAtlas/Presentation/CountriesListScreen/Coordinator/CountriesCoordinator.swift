//
//  CountriesCoordinator.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 13.05.2023.
//

import UIKit

final class CountriesCoordinator: Coordinator {
    
    // MARK: - Properties
    
    let rootNavigationController: UINavigationController
    let repository: Repository
    
    weak var delegate: AppCoordinator?
    
    // MARK: - Coordinator
    
    init(rootNavigationController: UINavigationController, repository: Repository) {
        self.rootNavigationController = rootNavigationController
        self.repository = repository
    }
    
    override func start() {
        
        let countriesViewModel = CountriesViewModel(repository: repository)
        countriesViewModel.coordinatorDelegate = self
        
        let countriesViewController = CountriesViewController(viewModel: countriesViewModel)
        countriesViewController.title = "World countries"
        
        rootNavigationController.setViewControllers([countriesViewController], animated: false)
    }
}

extension CountriesCoordinator: CountriesViewModelCoordinatorDelegate {
    
    
    func didTapLearnMoreButton(ccaTwoCode: String) {
        let detailsCoordinator = DetailsCoordinator(rootNavigationController: rootNavigationController, repository: repository, ccaTwoCode: ccaTwoCode)
        
        detailsCoordinator.delegate = self
        addChildCoordinator(detailsCoordinator)
        detailsCoordinator.start()
    }
    
}

// MARK: - Coordinator Delegate

extension CountriesCoordinator: DetailsCoordinatorProtocol {
    func didFinish(from coordinator: DetailsCoordinator) {
        removeChildCoordinator(coordinator)
    }
}
