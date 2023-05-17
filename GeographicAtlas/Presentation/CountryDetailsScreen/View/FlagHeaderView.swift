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
        imageView.image = getBackImage()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        flagImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(Constants.insets)
            make.bottom.equalTo(Constants.flagImageBottom)
        }
    }
}

extension FlagHeaderView {
    private static func getBackImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: Constants.imageSize)
        let image = renderer.image { context in
            Constants.skeletonImageColor.setFill()
            let rect = CGRect(origin: .zero, size: Constants.imageSize)
            let path = UIBezierPath(rect: rect)
            path.fill()
        }
        return image
    }
}

private extension Constants {
    static let insets = CGFloat(16)
    static let flagImageBottom = CGFloat(-21)
    static let imageSize = CGSize(width: 300, height: 200)
    static let skeletonImageColor = UIColor(red: 0.955, green: 0.955, blue: 0.965, alpha: 1)
}
