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
        setTableView()
    }

}

// MARK: - UITableViewDelegate

extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}

// MARK: - UITableViewDataSource

extension CountriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountriesTableViewCell.cellId, for: indexPath) as? CountriesTableViewCell else { return UITableViewCell() }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.frame.width / Constants.TableView.heightDivision
        return height
    }
    
}

// MARK: - Private Methods

private extension CountriesViewController {
    func setTableView() {
        rootView.countriesTableView.delegate = self
        rootView.countriesTableView.dataSource = self
        rootView.countriesTableView.register(CountriesTableViewCell.self, forCellReuseIdentifier: CountriesTableViewCell.cellId)
    }
}
