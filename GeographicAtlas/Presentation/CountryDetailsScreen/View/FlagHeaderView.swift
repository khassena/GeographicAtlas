//
//  FlagHeaderView.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 16.05.2023.
//

import UIKit
import SnapKit

class FlagHeaderView: UIView {

    let flagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupPosition()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupPosition()
        
        
    }
    private func setupPosition() {
        addSubview(flagImageView)
        
//        flagImageView.layer.cornerRadius = 10
//        flagImageView.clipsToBounds = true
//        flagImageView.contentMode = .scaleAspectFill
        
        flagImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(16)
            make.bottom.equalTo(-21)
//            make.centerY.equalToSuperview()
//            make.centerX.equalToSuperview()
//            make.width.equalTo(UIScreen.main.bounds.width).offset(-32)
//            make.height.equalTo(flagImageView.snp.width).dividedBy(1.7)
//            make.height.equalTo(flagImageView.snp.width).dividedBy(1.7)
        }
    }
}

private extension Constants {
    static let insets = CGFloat(16)
    static let divider = CGFloat(1.7)
}
