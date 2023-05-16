//
//  HeaderSectionView.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 16.05.2023.
//

import UIKit
import SnapKit

class HeaderSectionView: UIView {
    
    let headerLabel: UILabel = HeaderSectionView.createHeaderLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(12)
            make.top.equalToSuperview()
        }
        
    }
}

extension HeaderSectionView {
    
    static func createHeaderLabel() -> UILabel {
        let headerLabel = UILabel()
        
        headerLabel.textColor = Constants.Color.headerColor
        headerLabel.font = UIFont.regularBold
        
        return headerLabel
    }
}
