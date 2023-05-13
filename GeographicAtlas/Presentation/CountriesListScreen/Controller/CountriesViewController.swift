//
//  ViewController.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 12.05.2023.
//

import UIKit

class CountriesViewController: UIViewController {
    
    let network = NetworkTask()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        network.getCountry(ccaTwo: "ES", completion: { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        })
        
    }

}

