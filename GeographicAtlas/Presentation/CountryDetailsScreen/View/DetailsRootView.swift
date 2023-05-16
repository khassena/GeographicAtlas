//
//  DetailsRootView.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 16.05.2023.
//

import UIKit
import SnapKit

class DetailsRootView: UIView {

    // MARK: - Views
    
    let separatorbottomLine = UIView()
    let detailsTableView = UITableView()
    
    // MARK: - Setup View
    
    func setup() {
        [separatorbottomLine, detailsTableView].forEach { addSubview($0) }
        backgroundColor = .white
        separatorbottomLine.backgroundColor = .systemGray
        setTableView()
        
        separatorbottomLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(Constants.Navigation.separatorHeight)
        }
        
        detailsTableView.snp.makeConstraints { make in
            make.top.equalTo(separatorbottomLine.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

}

private extension DetailsRootView {
    private func setTableView() {
        detailsTableView.separatorStyle = .none
        detailsTableView.showsVerticalScrollIndicator = false
        detailsTableView.showsHorizontalScrollIndicator = false
        
    }
}

// MARK: - Constants

private extension Constants {
    struct Navigation {
        static let separatorHeight = CGFloat(0.2)
    }
}
