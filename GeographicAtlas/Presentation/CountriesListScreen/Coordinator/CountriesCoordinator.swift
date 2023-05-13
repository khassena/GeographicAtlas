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
        
        let countriesViewController = CountriesViewController()
        countriesViewController.title = "World countries"
        
        rootNavigationController.setViewControllers([countriesViewController], animated: false)
    }
}
