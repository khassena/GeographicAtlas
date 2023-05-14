//
//  CountriesRootView.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 13.05.2023.
//

import UIKit
import SnapKit

class CountriesRootView: UIView {

    // MARK: - Views
    
    let separatorbottomLine = UIView()
    let countriesTableView = UITableView()
    
    // MARK: - Setup View
    
    func setup() {
        [separatorbottomLine, countriesTableView].forEach { addSubview($0) }
        backgroundColor = .white
        separatorbottomLine.backgroundColor = .systemGray
        setTableView()
        
        separatorbottomLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(Constants.Navigation.separatorHeight)
        }
        
        countriesTableView.snp.makeConstraints { make in
            make.top.equalTo(separatorbottomLine.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

}

private extension CountriesRootView {
    private func setTableView() {
        countriesTableView.separatorStyle = .none
        countriesTableView.showsVerticalScrollIndicator = false
        countriesTableView.showsHorizontalScrollIndicator = false
    }
}

// MARK: - Constants

private extension Constants {
    struct Navigation {
        static let separatorHeight = CGFloat(0.2)
    }
}
