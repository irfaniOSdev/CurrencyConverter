//
//  CurrencySelectionViewController.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 31/10/2023.
//

import UIKit
import Combine
protocol CurrencySelectionDelegate: AnyObject {
    func didSelectCurrency(currency: CurrencyDetail)
}

class CurrencySelectionViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!

    private var viewModel: CurrencyListViewModel!

    private var dataSource: UITableViewDiffableDataSource<Section, CurrencyDetail>!

    private var cancellables: Set<AnyCancellable> = []
    
    weak var delegate: CurrencySelectionDelegate?

    init(viewModel: CurrencyListViewModel) {
        super.init(nibName: "CurrencySelectionViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        Spinner.start()
        viewModel.fetchData()
        dataBinding()

    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.register(cellType: CurrencyCodeTableViewCell.self)
        dataSource = UITableViewDiffableDataSource<Section, CurrencyDetail>(tableView: tableView) { tableView, indexPath, currency in
            let cell = tableView.dequeueReusableCell(with: CurrencyCodeTableViewCell.self, for: indexPath)
            cell.name = currency.getFullName()
            return cell
        }
    }
    
    func dataBinding() {
        viewModel.$currencies
            .sink { [weak self] currencies in
                var snapshot = NSDiffableDataSourceSnapshot<Section, CurrencyDetail>()
                snapshot.appendSections([.main])
                snapshot.appendItems(currencies)
                self?.dataSource.apply(snapshot, animatingDifferences: true)
                Spinner.stop()
            }
            .store(in: &cancellables)
    }
}

extension CurrencySelectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = viewModel.currencies[indexPath.row]
        delegate?.didSelectCurrency(currency: currency)
        navigationController?.popViewController(animated: true)
    }
}
