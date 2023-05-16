//
//  ViewController.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 12.05.2023.
//

import UIKit

class CountriesViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: CountriesViewModelProtocol
    var rootView: CountriesRootView {
        return self.view as! CountriesRootView
    }
    let expandedCell: CountriesTableViewCell = {
        let cell = CountriesTableViewCell()
        cell.isSelected = true
        return cell
    }()
    let collapsedCell: CountriesTableViewCell = {
        let cell = CountriesTableViewCell()
        cell.isSelected = false
        return cell
    }()
    private var countries: [[CountriesListData]]?
    
    // MARK: - Initialization
    
    init(viewModel: CountriesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = CountriesRootView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.setup()
        setTableView()
        bindToViewModel()
        
    }

}

// MARK: - UITableViewDelegate

extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: return self.countries?[0].count ?? 0
        case 1: return self.countries?[1].count ?? 0
        case 2: return self.countries?[2].count ?? 0
        case 3: return self.countries?[3].count ?? 0
        case 4: return self.countries?[4].count ?? 0
        case 5: return self.countries?[5].count ?? 0
        case 6: return self.countries?[6].count ?? 0
        default:
            return 0
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    internal func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0: return ContinentsModel.europe.name
        case 1: return ContinentsModel.asia.name
        case 2: return ContinentsModel.africa.name
        case 3: return ContinentsModel.southAmerica.name
        case 4: return ContinentsModel.northAmerica.name
        case 5: return ContinentsModel.oceania.name
        case 6: return ContinentsModel.antarctica.name
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            
            headerView.contentView.preservesSuperviewLayoutMargins = false
            headerView.textLabel?.font = UIFont.regularBold
            headerView.textLabel?.textColor = Constants.Color.headerColor
        }
    }
    
    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(30)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? CountriesTableViewCell
        cell?.changeArrowSide()
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.performBatchUpdates(nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? CountriesTableViewCell
        cell?.changeArrowSide()
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        UIView.animate(withDuration: Constants.TableView.animationDuration) {
            tableView.performBatchUpdates(nil)
        }
        DispatchQueue.main.async {
            tableView.scrollToRow(at: indexPath, at: .none, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource

extension CountriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountriesTableViewCell.cellId, for: indexPath) as? CountriesTableViewCell,
              let country = self.countries?[indexPath.section][indexPath.row],
              let flagImageURL = URL(string: country.flagUrl)
               else { return UITableViewCell() }
        cell.delegate = self
        cell.configureCell(country)
        viewModel.reloadImage(with: flagImageURL, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let height = tableView.frame.width / Constants.TableView.heightDivision
        
        let isSelected = tableView.indexPathsForSelectedRows?.contains(indexPath) ?? false
        let expandedHeight = expandedCell.systemLayoutSizeFitting(
            CGSize(width: tableView.frame.width, height: .zero),
                        withHorizontalFittingPriority: .required,
                        verticalFittingPriority: .defaultLow
        ).height + Constants.TableView.expandedMardins
        let collapsedHeight = collapsedCell.systemLayoutSizeFitting(
            CGSize(width: tableView.frame.width, height: .zero),
                        withHorizontalFittingPriority: .required,
                        verticalFittingPriority: .defaultLow
        ).height + Constants.TableView.expandedMardins
        let finalHeight: CGFloat = isSelected ? expandedHeight : collapsedHeight
        return finalHeight
    }
    
}

extension CountriesViewController: CountriesTableViewCellDelegate {
    func didTapLearnMoreButton(ccaTwoCode: String) {
        viewModel.learnMoreTapped(ccaTwoCode: ccaTwoCode)
    }
}

// MARK: - Private Methods

private extension CountriesViewController {
    
    func setTableView() {
        rootView.countriesTableView.delegate = self
        rootView.countriesTableView.dataSource = self
        rootView.countriesTableView.register(CountriesTableViewCell.self, forCellReuseIdentifier: CountriesTableViewCell.cellId)
    }
    
    func bindToViewModel() {
        viewModel.didRecieveData = { countries in
            self.countries = countries
            self.rootView.countriesTableView.reloadData()
        }
        
        viewModel.didRecieveImage = { image, indexPath in
            DispatchQueue.main.async {
                let cell = self.rootView.countriesTableView.cellForRow(at: indexPath) as? CountriesTableViewCell
                cell?.setImage(with: image)
                
            }
            
        }
    }
}

