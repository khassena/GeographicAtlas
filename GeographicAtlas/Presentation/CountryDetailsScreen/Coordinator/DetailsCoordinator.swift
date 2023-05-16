//
//  DetailsCoordinator.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 16.05.2023.
//

import UIKit

protocol DetailsCoordinatorProtocol: Coordinator {
    func didFinish(from coordinator: DetailsCoordinator)
}

final class DetailsCoordinator: Coordinator {
    
    // MARK: - Properties
    
    let rootNavigationController: UINavigationController
    let repository: RepositoryProtocol
    let ccaTwoCode: String
    
    weak var delegate: DetailsCoordinatorProtocol?
    
    // MARK: - Coordinator
    
    init(rootNavigationController: UINavigationController, repository: RepositoryProtocol, ccaTwoCode: String) {
        self.rootNavigationController = rootNavigationController
        self.repository = repository
        self.ccaTwoCode = ccaTwoCode
    }
    
    override func start() {
        
        let detailsViewModel = DetailsViewModel(repository: repository)
        
        let detailsViewController = DetailsViewController(viewModel: detailsViewModel)
        
        rootNavigationController.pushViewController(detailsViewController, animated: true)
    }
    
    override func finish() {
        delegate?.didFinish(from: self)
    }
}

// MARK: - ViewModel Delegate

extension DetailsCoordinator: ViewModelCoordinatorDelegate {
    
    func viewWillDisappear() {
        self.finish()
    }
    
    func didTapLearnMore(ccaTwoCode: String) {
        let detailsCoordinator = DetailsCoordinator(rootNavigationController: rootNavigationController, repository: repository, ccaTwoCode: ccaTwoCode)
        
        detailsCoordinator.delegate = self.delegate
        self.delegate?.addChildCoordinator(detailsCoordinator)
        rootNavigationController.navigationBar.prefersLargeTitles = false
        detailsCoordinator.start()
    }
}
