//
//  CountriesRootView.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 13.05.2023.
//

import UIKit
import SnapKit

class CountriesRootView: UIView {

    let separatorbottomLine = UIView()
    
    func setup() {
        addSubview(separatorbottomLine)
        backgroundColor = .white
        separatorbottomLine.backgroundColor = .systemGray
        
        separatorbottomLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(Constants.Navigation.separatorHeight)
        }
    }

}

// MARK: - Constants

private extension Constants {
    struct Navigation {
        static let separatorHeight = CGFloat(0.2)
    }
}
