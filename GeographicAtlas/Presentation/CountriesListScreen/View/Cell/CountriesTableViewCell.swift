//
//  CountriesTableViewCell.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 13.05.2023.
//

import UIKit
import SnapKit

protocol CountriesTableViewCellDelegate: AnyObject {
    func didTapLearnMoreButton(ccaTwoCode: String)
}

class CountriesTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellId = "CountriesTableViewCell"
    
    weak var delegate: CountriesTableViewCellDelegate?
    private var ccaTwoCode = String()
    
    private var expandedConstraint: Constraint!
    private var collapsedConstraint: Constraint!
    
    private let spacer = UIView()
    private let flagImageView = makeFlagImage()
    private let countryNameLabel = makeTitleLabel()
    private let capitalCityLabel = makeSubTitleLabel()
    private let arrowImageView = makeArrowImage()
    private let populationLabel = makePropertyLabel(Constants.Property.population)
    private let populationValueLabel = makePropertyValueLabel()
    private let areaLabel = makePropertyLabel(Constants.Property.area)
    private let areaValueLabel = makePropertyValueLabel()
    private let currenciesLabel = makePropertyLabel(Constants.Property.currency)
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
    
    override var isSelected: Bool {
        didSet {
            changeAppearance()
        }
    }
    
}

// MARK: - Public Methods

extension CountriesTableViewCell {
    
    func changeAppearance() {
        collapsedConstraint.isActive = !isSelected
        expandedConstraint.isActive = isSelected
    }
    
    func changeArrowSide() {
        UIView.animate(withDuration: Constants.TableView.animationDuration) {
            let upsideDown = CGAffineTransform(rotationAngle: .pi * Constants.Numbers.rotationNum )
            self.arrowImageView.transform = self.isSelected ? upsideDown : .identity
        }
    }
    
    func configureCell(_ country: CountriesListData) {
        
        countryNameLabel.text = country.countryName
        capitalCityLabel.text = country.capitalCity
        populationValueLabel.text = country.population
        areaValueLabel.text = country.area
        currenciesValueLabel.text = country.currency
        ccaTwoCode = country.ccaTwoCode
    }
    
    func setImage(with image: UIImage) {
        flagImageView.image = image
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
        
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
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
        
        arrowImageView.image = Constants.Image.arrowImage
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.layer.masksToBounds = true
        
        return arrowImageView
    }
    
    static func makePropertyLabel(_ title: String) -> UILabel {
        let propertyLabel = UILabel()
        
        propertyLabel.text = title
        propertyLabel.font = UIFont.regularMedium
        propertyLabel.textColor = Constants.Color.gray
        propertyLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return propertyLabel
    }
    
    static func makePropertyValueLabel() -> UILabel {
        let propertyValueLabel = UILabel()
        
        propertyValueLabel.font = UIFont.regularMedium
        propertyValueLabel.textColor = Constants.Color.black
        propertyValueLabel.adjustsFontSizeToFitWidth = true
        propertyValueLabel.minimumScaleFactor = 0.5
        propertyValueLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
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
    
    func setupViews() {
        selectionStyle = .none
        countryTitleStackView.alignment = .leading
        collapsedStackView.alignment = .center
        contentView.backgroundColor = Constants.Color.backgroundGray
        contentView.layer.cornerRadius = Constants.ContentView.cornerRadius
        expandedStackView.setCustomSpacing(Constants.StackView.largeSpacing, after: currenciesStackView)
        expandedStackView.setCustomSpacing(Constants.StackView.hugeSpacing, after: learnMoreButton)
        
        collapsedStackView.layoutMargins.right = Constants.Image.arrowTrailing
        collapsedStackView.isLayoutMarginsRelativeArrangement = true
        contentView.clipsToBounds = true
        learnMoreButton.addTarget(self, action: #selector(didTapLearnButton), for: .touchUpInside)
    }
    
    func setupViewPosition() {
        
        [collapsedStackView, expandedStackView].forEach { contentView.addSubview($0)}
        
        flagImageView.snp.makeConstraints { make in
            make.width.equalTo(contentView).dividedBy(Constants.Image.flagWidthDiv)
        }
        
        collapsedStackView.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView).inset(Constants.StackView.standardSpacing)
            make.height.equalTo(collapsedStackView.snp.width).dividedBy(Constants.StackView.collapsedHeightDiv)
        }
        
        collapsedStackView.snp.prepareConstraints { make in
            collapsedConstraint = make.bottom.equalTo(contentView.snp.bottom).constraint
            collapsedConstraint.layoutConstraints.first?.priority = .defaultLow
        }
        
        expandedStackView.snp.makeConstraints { make in
            make.top.equalTo(collapsedStackView.snp.bottom).inset(Constants.StackView.expandedSpacing)
            make.left.right.equalTo(contentView).inset(Constants.StackView.standardSpacing)
            if UIDevice.current.userInterfaceIdiom == .pad {
                make.height.equalTo(expandedStackView.snp.width).dividedBy(3.5)
            }
        }
        
        expandedStackView.snp.prepareConstraints { make in
            expandedConstraint = make.bottom.equalTo(contentView.snp.bottom).constraint
            expandedConstraint.layoutConstraints.first?.priority = .defaultLow
        }
        
    }
    
    @objc func didTapLearnButton() {
        delegate?.didTapLearnMoreButton(ccaTwoCode: ccaTwoCode)
    }
    
}

// MARK: - Constants

private extension Constants {
    
    struct StackView {
        static let zeroSpacer = CGFloat(0)
        static let smallSpacing = CGFloat(4)
        static let mediumSpacing = CGFloat(8)
        static let standardSpacing = CGFloat(12)
        static let hugeSpacing = CGFloat(12)
        static let largeSpacing = CGFloat(12)
        static let collapsedHeightDiv = CGFloat(6.64)
        static var expandedSpacing = CGFloat(-14)
    }
    
    struct Text {
        static let buttonText = "Learn more"
    }
    
    struct Image {
        static let arrowImage = UIImage(named: "arrowDown")
        static let flagWidthDiv = CGFloat(4.18)
        static let flagHeightDiv = CGFloat(1.7)
        static let arrowTrailing = CGFloat(4.75)
    }
    
    struct ContentView {
        static let cornerRadius = CGFloat(12)
        static let insets = UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)
    }
    
    struct Property {
        static let population = "Population:"
        static let area = "Area:"
        static let currency = "Currencies:"
    }
}
