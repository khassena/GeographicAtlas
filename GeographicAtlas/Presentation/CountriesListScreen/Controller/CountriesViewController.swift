//
//  ViewController.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 12.05.2023.
//

import UIKit

class CountriesViewController: UIViewController {
    
    var rootView: CountriesRootView {
        return self.view as! CountriesRootView
    }
    
    override func loadView() {
        super.loadView()
        self.view = CountriesRootView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.setup()
    }

}

