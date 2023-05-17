//
//  DetailsViewController.swift
//  GeographicAtlas
//
//  Created by Amanzhan Zharkynuly on 16.05.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: DetailsViewModelProtocol
    var rootView: DetailsRootView {
        return self.view as! DetailsRootView
    }
    let tempCell: DetailsTableViewCell = {
        let cell = DetailsTableViewCell()
        return cell
    }()
    var flagHeaderView: FlagHeaderView?
    var countryDetails: [String]?
    
    // MARK: - Initialization
    
    init(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = DetailsRootView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.setup()
        setTableView()
        bindToViewModel()
    }

}

// MARK: - UITableViewDelegate

extension DetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = countryDetails else { return .zero }
        return Constants.Country.countryPropertiesCount
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.Numbers.one
    }
    
}

// MARK: - UITableViewDataSource

extension DetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.cellId, for: indexPath) as? DetailsTableViewCell,
              let countryDetail = countryDetails?[indexPath.row] else { return UITableViewCell() }
        
        cell.configureCell(countryDetail, index: indexPath.row)
        tempCell.configureCell(countryDetail, index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tempCell.systemLayoutSizeFitting(
            CGSize(width: tableView.frame.width, height: .zero),
                        withHorizontalFittingPriority: .required,
                        verticalFittingPriority: .defaultLow
        ).height + Constants.TableView.countryCellMargins
        return height
    }
    
}

// MARK: - Private Methods

private extension DetailsViewController {
    
    func setTableView() {
        rootView.detailsTableView.delegate = self
        rootView.detailsTableView.dataSource = self
        rootView.detailsTableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.cellId)
        flagHeaderView = FlagHeaderView(frame: CGRect(x: .zero, y: .zero, width: self.view.frame.width, height: UIScreen.main.bounds.width * Constants.TableView.flagHeightCoefficent ))
        rootView.detailsTableView.tableHeaderView = flagHeaderView
        rootView.detailsTableView.rowHeight = UITableView.automaticDimension
        rootView.detailsTableView.estimatedRowHeight = Constants.TableView.estimatedHeight
        
    }
    
    func bindToViewModel() {
        viewModel.didRecieveData = { [weak self] (country, countryName) in
            DispatchQueue.main.async {
                self?.countryDetails = country
                self?.title = countryName
                self?.rootView.detailsTableView.reloadData()
            }
        }
        
        viewModel.didRecieveImage = { [weak self] image in
            DispatchQueue.main.async {
                self?.flagHeaderView?.flagImageView.image = image
            }
        }
    }
}
