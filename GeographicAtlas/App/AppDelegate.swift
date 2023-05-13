//
//  AppDelegate.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 12.05.2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        self.window?.makeKeyAndVisible()
        self.appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
        
        return true
    }

}

