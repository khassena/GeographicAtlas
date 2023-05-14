//
//  CountriesTableViewCell.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 13.05.2023.
//

import UIKit
import SnapKit

class CountriesTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellId = "ListTableViewCell"
    
    private let flagImageView = makeFlagImage()
    private let countryNameLabel = makeTitleLabel()
    private let capitalCityLabel = makeSubTitleLabel()
    private let arrowImageView = makeArrowImage()
    private let populationLabel = makePropertyLabel()
    private let populationValueLabel = makePropertyValueLabel()
    private let areaLabel = makePropertyLabel()
    private let areaValueLabel = makePropertyValueLabel()
    private let currenciesLabel = makePropertyLabel()
    private let currenciesValueLabel = makePropertyValueLabel()
    private let learnMoreButton = makeLearnMoreButton()
    
    private lazy var countryTitleStackView = CountriesTableViewCell.makeStackView([countryNameLabel, capitalCityLabel], .vertical, Constants.StackView.smallSpacing)
    private lazy var populationStackView = CountriesTableViewCell.makeStackView([populationLabel, populationValueLabel], .horizontal, Constants.StackView.smallSpacing)
    private lazy var areaStackView = CountriesTableViewCell.makeStackView([areaLabel, areaValueLabel], .horizontal, Constants.StackView.smallSpacing)
    private lazy var currenciesStackView = CountriesTableViewCell.makeStackView([currenciesLabel, currenciesValueLabel], .horizontal, Constants.StackView.smallSpacing)
    private lazy var collapsedStackView = CountriesTableViewCell.makeStackView([flagImageView, countryTitleStackView, arrowImageView], .horizontal, Constants.StackView.standardSpacing)
    private lazy var expandedStackView = CountriesTableViewCell.makeStackView([populationStackView, areaStackView, currenciesStackView, learnMoreButton], .vertical, Constants.StackView.mediumSpacing)
    private lazy var generalStackView = CountriesTableViewCell.makeStackView([collapsedStackView, expandedStackView], .vertical, Constants.StackView.standardSpacing)
    
    
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Creating SubViews

private extension CountriesTableViewCell {
    
    static func makeFlagImage() -> UIImageView {
        let flagImageView = UIImageView()
        
        flagImageView.layer.masksToBounds = true
        flagImageView.layer.cornerRadius = Constants.Countries.imageCornerRadius
        
        return flagImageView
    }
    
    static func makeTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        
        titleLabel.font = UIFont.semiboldStandard
        titleLabel.textColor = Constants.Color.boldBlack
        
        return titleLabel
    }
    
    static func makeSubTitleLabel() -> UILabel {
        let subtitleLabel = UILabel()
        
        subtitleLabel.font = UIFont.regularThin
        subtitleLabel.textColor = Constants.Color.gray
        
        return subtitleLabel
    }
    
    static func makeArrowImage() -> UIImageView {
        let arrowImageView = UIImageView()
        
        arrowImageView.layer.masksToBounds = true
        
        return arrowImageView
    }
    
    static func makePropertyLabel() -> UILabel {
        let propertyLabel = UILabel()
        
        propertyLabel.font = UIFont.regularMedium
        propertyLabel.textColor = Constants.Color.gray
        
        return propertyLabel
    }
    
    static func makePropertyValueLabel() -> UILabel {
        let propertyValueLabel = UILabel()
        
        propertyValueLabel.font = UIFont.regularMedium
        propertyValueLabel.textColor = Constants.Color.black
        
        return propertyValueLabel
    }
    
    static func makeLearnMoreButton() -> UIButton {
        let learnMoreButton = UIButton(type: .system)
        
        learnMoreButton.titleLabel?.font = UIFont.semiboldStandard
        learnMoreButton.setTitleColor(Constants.Color.blueButton, for: .normal)
        learnMoreButton.backgroundColor = .clear
        learnMoreButton.setTitle(Constants.Text.buttonText, for: .normal)
        
        return learnMoreButton
    }
    
    static func makeStackView(_ views: [UIView], _ axis: NSLayoutConstraint.Axis, _ spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }
}

// MARK: - Private Methods

private extension CountriesTableViewCell {
    
    func setupView() {
        addSubview(generalStackView)
        expandedStackView.setCustomSpacing(Constants.StackView.largeSpacing, after: currenciesStackView)
        expandedStackView.setCustomSpacing(Constants.StackView.hugeSpacing, after: learnMoreButton)
        expandedStackView.isHidden = true
        
        flagImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(Constants.Image.widthDivision)
        }
        
        generalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Constants.StackView.standardSpacing)
        }
    }
    
}

// MARK: - Constants

private extension Constants {
    
    struct StackView {
        static let smallSpacing = CGFloat(4)
        static let mediumSpacing = CGFloat(8)
        static let standardSpacing = CGFloat(12)
        static let hugeSpacing = CGFloat(16)
        static let largeSpacing = CGFloat(26)
    }
    
    struct Text {
        static let buttonText = "Learn more"
    }
    
    struct Image {
        static let widthDivision = CGFloat(3.9)
    }
}
