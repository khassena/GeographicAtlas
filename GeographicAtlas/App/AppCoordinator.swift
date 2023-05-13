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
//        navigationController.navigationBar.barTintColor =
        return navigationController
    }()
    
    let networkTask: NetworkTask
    let repository: Repository
    
    // MARK: - Coordinator
    
    init(window: UIWindow) {
        self.window = window
        networkTask = NetworkTask()
        repository = Repository()
    }
    
    override func start() {
        guard let window = window else {
            return
        }
        
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()
        
    }
}
