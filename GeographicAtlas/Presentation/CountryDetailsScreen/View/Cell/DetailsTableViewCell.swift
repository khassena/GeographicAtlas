//
//  DetailsTableViewCell.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 16.05.2023.
//

import UIKit
import SnapKit

class DetailsTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let cellId = "DetailsTableViewCell"
    
    private let spacer = UIView()
    private let dotImageView = makeDotImage()
    private let propertyName = makeTitleLabel()
    private let propertyValue = makeSubTitleLabel()
//    private let capitalLabel = makeTitleLabel()
//    private let capitalValueLabel = makeSubTitleLabel()
//    private let coordinatesLabel = makeTitleLabel()
//    private let coordinatesValueLabel = makeSubTitleLabel()
//    private let populationLabel = makeTitleLabel()
//    private let populationValueLabel = makeSubTitleLabel()
    private lazy var imageStackView = DetailsTableViewCell.makeStackView([spacer, dotImageView], .vertical, Constants.StackView.spacerSpacing)
    private lazy var titlesStackView = DetailsTableViewCell.makeStackView([propertyName, propertyValue], .vertical, Constants.StackView.titleSpacing)
    private lazy var generalStackView = DetailsTableViewCell.makeStackView([imageStackView, titlesStackView], .horizontal, Constants.StackView.generalSpacing)
    
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
        contentView.frame = contentView.frame.inset(by: Constants.ContentView.insets)
    }

}

// MARK: - Public Methods

extension DetailsTableViewCell {
    func configureCell(_ value: String, index: Int) {
        switch index {
        case 0:
            propertyName.text = "Region:"
            propertyValue.text = value
        case 1:
            propertyName.text = "Capital:"
            propertyValue.text = value
        case 2:
            propertyName.text = "Capital coordinates:"
            propertyValue.text = value
        case 3:
            propertyName.text = "Population:"
            propertyValue.text = value
        case 4:
            propertyName.text = "Area:"
            propertyValue.text = value
        case 5:
            propertyName.text = "Currency:"
            propertyValue.text = value
        case 6:
            propertyName.text = "Timezones:"
            propertyValue.text = value
        default:
            print("error")
        }
    }
}

// MARK: - Creating SubViews

private extension DetailsTableViewCell {

    static func makeDotImage() -> UIImageView {
        let dotImageView = UIImageView()
        
        dotImageView.image = Constants.Image.dotImage
        dotImageView.layer.masksToBounds = true
        dotImageView.contentMode = .scaleAspectFit
        
        return dotImageView
    }
    
    static func makeTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont.regularMedium
        titleLabel.textColor = Constants.Color.gray
        
        return titleLabel
    }
    
    static func makeSubTitleLabel() -> UILabel {
        let subtitleLabel = UILabel()
        
        subtitleLabel.font = UIFont.regularLarge
        subtitleLabel.textColor = Constants.Color.boldBlack
        subtitleLabel.numberOfLines = 2
        
        return subtitleLabel
    }

    static func makeStackView(_ views: [UIView], _ axis: NSLayoutConstraint.Axis, _ spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = .leading
        stackView.distribution = .fill
        
        return stackView
    }

}

// MARK: - Private Methods

private extension DetailsTableViewCell {
    
    func setupViews() {
        selectionStyle = .none

    }
    
    func setupViewPosition() {
//        [dotImageView, titlesStackView].forEach { contentView.addSubview($0) }
        contentView.addSubview(generalStackView)
//        imageStackView.alignment = .leading
        
        generalStackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        dotImageView.snp.makeConstraints { make in
            make.width.equalTo(Constants.Image.dotImageWidth)
            make.height.equalTo(Constants.Image.dotImageHeight)
            
        }
        spacer.snp.makeConstraints { make in
            make.height.equalTo(0)
            make.width.equalTo(0)
        }
        
        imageStackView.snp.makeConstraints { make in
            make.width.equalTo(dotImageView.snp.width)
        }
        
//        titlesStackView.snp.makeConstraints { make in
//            make.height.equalTo(titlesStackView.snp.width).dividedBy(6.76)
//        }
    }
}

// MARK: - Constants

private extension Constants {
    
    struct StackView {
        static let titleSpacing = CGFloat(4)
        static let spacerSpacing = CGFloat(7)
        static let generalSpacing = CGFloat(8)
    }
    
    struct Text {
        
    }
    
    struct Image {
        static let dotImage = UIImage(named: "dot")
        static let dotImageWidth = CGFloat(24)
        static let dotImageHeight = CGFloat(10)
    }
    
    struct ContentView {
        static let insets = UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)
    }
}


