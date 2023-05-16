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
        
        return 7
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return CGFloat(67)
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as? CountriesTableViewCell
        
    }
}

// MARK: - UITableViewDataSource

extension DetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.cellId, for: indexPath) as? DetailsTableViewCell else { return UITableViewCell() }
        if indexPath.row == 1 {
            cell.propertyValue.text = "Euro (€) (EUR) CFP franc (XPF) CFP franc (XPF)"
            tempCell.propertyValue.text = "Euro (€) (EUR) CFP franc (XPF) CFP franc (XPF)"
        } else {
            cell.propertyValue.text = "sdfsdf"
            tempCell.propertyValue.text = "sdfsdf"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tempCell.systemLayoutSizeFitting(
            CGSize(width: tableView.frame.width, height: .zero),
                        withHorizontalFittingPriority: .required,
                        verticalFittingPriority: .defaultLow
        ).height + 12
        return height
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        view.layoutMargins = insets
        view.preservesSuperviewLayoutMargins = true
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return HeaderSectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
//    }
}

// MARK: - Private Methods

private extension DetailsViewController {
    
    func setTableView() {
        rootView.detailsTableView.delegate = self
        rootView.detailsTableView.dataSource = self
        rootView.detailsTableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.cellId)
        rootView.detailsTableView.tableHeaderView = FlagHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: UIScreen.main.bounds.width * 0.63 ))
        rootView.detailsTableView.rowHeight = UITableView.automaticDimension
        rootView.detailsTableView.estimatedRowHeight = 100
    }
    
    func bindToViewModel() {
        
    }
}
