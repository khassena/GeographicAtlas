//
//  DetailsSkeletonTableViewCell.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 17.05.2023.
//

import UIKit
import SnapKit

class DetailsSkeletonTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    let skeletonImage = DetailsSkeletonTableViewCell.skeletonImageView()
    let skeletonNameView = DetailsSkeletonTableViewCell.skeletonTempView(frame: Constants.Skeleton.nameFrame, radius: Constants.Skeleton.nameCornerRadius)
    let skeletonPositionView = DetailsSkeletonTableViewCell.skeletonTempView(frame: Constants.Skeleton.posFrame, radius:Constants.Skeleton.posCornerRadius)
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupViewPosition()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViewPosition()
        contentView.frame = contentView.frame.inset(by: Constants.ContentView.insets)
    }

}

// MARK: - Creating SubViews

private extension DetailsSkeletonTableViewCell {
    
    private static func addGradientLayer() -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [Constants.Skeleton.skeletonStart, Constants.Skeleton.skeletonEnd]
        gradient.locations = [0, 1]
        gradient.startPoint = Constants.Gradient.start
        gradient.endPoint = Constants.Gradient.end
        return gradient
    }
    
    private static func skeletonImageView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = Constants.Skeleton.imageFrame
        let layer = DetailsSkeletonTableViewCell.addGradientLayer()
        layer.frame = view.bounds
        layer.cornerRadius = Constants.Skeleton.imageCornerRadius
        view.layer.addSublayer(layer)
        return view
    }
    
    private static func skeletonTempView(frame: CGRect, radius: CGFloat) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = frame
        let layer = DetailsSkeletonTableViewCell.addGradientLayer()
        layer.frame = view.bounds
        layer.cornerRadius = radius
        view.layer.addSublayer(layer)
        return view
    }
}

// MARK: - Private Methods

private extension DetailsSkeletonTableViewCell {
    
    func setupViews() {
        selectionStyle = .none
        
    }
    
    func setupViewPosition() {
        [skeletonImage, skeletonNameView, skeletonPositionView].forEach { contentView.addSubview($0) }

        skeletonImage.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(4)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }

        skeletonNameView.snp.makeConstraints { make in
            make.leading.equalTo(skeletonImage.snp.trailing).offset(Constants.StackView.standardSpacing)
            make.top.equalTo(skeletonPositionView.snp.bottom).offset(Constants.Skeleton.spacing)
            make.width.equalTo(Constants.Skeleton.positionViewWidth)
            make.height.equalTo(Constants.Skeleton.positionViewHeight)
        }

        skeletonPositionView.snp.makeConstraints { make in
            make.leading.equalTo(skeletonImage.snp.trailing).offset(Constants.StackView.standardSpacing)
            make.top.equalTo(contentView.snp.top).offset(Constants.Skeleton.skeletonNameTop)
            make.width.equalTo(Constants.Skeleton.nameViewWidth)
            make.height.equalTo(Constants.Skeleton.nameViewHeight)
        }
        
    }
    
}

// MARK: - Constants

private extension Constants {
    
    struct StackView {
        static let standardSpacing = CGFloat(16)
    }

    struct ContentView {
        static let cornerRadius = CGFloat(12)
        static let insets = UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)
    }
    
    enum Skeleton {
        static let imageCornerRadius: CGFloat = 36.0
        static let nameCornerRadius: CGFloat = 8.0
        static let posCornerRadius: CGFloat = 6.0
        static let skeletonStart = UIColor(red: 0.955, green: 0.955, blue: 0.965, alpha: 1).cgColor
        static let skeletonEnd = UIColor(red: 0.979, green: 0.979, blue: 0.981, alpha: 1).cgColor
        static let nameViewWidth: CGFloat = 144.0
        static let nameViewHeight: CGFloat = 20.0
        static let positionViewWidth: CGFloat = 80.0
        static let positionViewHeight: CGFloat = 15.0
        static let spacing: CGFloat = 4.0
        static let imageFrame: CGRect = CGRect(x: 0, y: 0, width: 10, height: 10)
        static let nameFrame: CGRect = CGRect(x: 0, y: 0, width: 144, height: 16)
        static let posFrame: CGRect = CGRect(x: 0, y: 0, width: 80, height: 12)
        static let skeletonNameTop: CGFloat = 12.0
    }
    
    enum Gradient {
        static let start: CGPoint = CGPoint(x: 0.25, y: 0.5)
        static let end: CGPoint = CGPoint(x: 0.75, y: 0.5)
    }
    
}
