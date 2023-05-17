//
//  AppCoordinator.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 13.05.2023.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    let window: UIWindow?
    let rootNavigationController: UINavigationController = {
        let navigationController = UINavigationController()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = Constants.Color.backgroundGray
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance

        return navigationController
    }()
    
    let networkTask: NetworkTask
    let repository: Repository
    
    // MARK: - Coordinator
    
    init(window: UIWindow) {
        self.window = window
        networkTask = NetworkTask()
        repository = Repository(networkTask: networkTask)
    }
    
    override func start() {
        guard let window = window else {
            return
        }
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        
        let countriesCoordinator = CountriesCoordinator(rootNavigationController: rootNavigationController, repository: repository)
        countriesCoordinator.delegate = self
        addChildCoordinator(countriesCoordinator)
        countriesCoordinator.start()
    }
}
