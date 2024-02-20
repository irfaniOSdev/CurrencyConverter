//
//  CurrencyViewController.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 29/10/2023.
//

import UIKit
import Combine

class CurrencyViewController: BaseViewController {

    @IBOutlet weak var enterAmountField: CurrencyAmountTextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var currencySelectionView: UIView!
    @IBOutlet weak var selectedCurrencyLabel: UILabel!
    
    private let viewModel: CurrencyViewModel
    private var dataSource: UICollectionViewDiffableDataSource<Section, CurrencyRate>!
    private var cancellables: Set<AnyCancellable> = []
    
    init(viewModel: CurrencyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: CurrencyViewController._nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterAmountField.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(openCurrencySelection))
        currencySelectionView.addGestureRecognizer(tapGestureRecognizer)

        setupCollectionView()
        dataBinding()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        currencySelectionView.layer.borderWidth = 1.0
        currencySelectionView.layer.borderColor = UIColor.lightGray.cgColor
        currencySelectionView.layer.cornerRadius = 10.0
    }
    
    
    @objc func openCurrencySelection() {
        let service = CurrencyListService()
        let viewModel = CurrencyListViewModel(dataService: service)
        let currencySelection = CurrencySelectionViewController(viewModel: viewModel)
        currencySelection.delegate = self
        navigationController?.pushViewController(currencySelection, animated: true)
    }
    
    func setupCollectionView(){
        collectionView.register(cellType: CurrencyCollectionViewCell.self)
        
        // Configure your UICollectionViewDiffableDataSource
        dataSource = UICollectionViewDiffableDataSource<Section, CurrencyRate>(collectionView: collectionView) {  [weak self] collectionView, indexPath, currencyRate in
            let cell = collectionView.dequeueReusableCell(with: CurrencyCollectionViewCell.self, for: indexPath)
            guard let self else { return cell }
            cell.currencyRate = viewModel.getCurrency(conversion:currencyRate, amountText: enterAmountField.text ?? "")
            return cell
        }      
    }
    
    func dataBinding() {
        viewModel.$conversions
            .sink { [weak self] conversions in
                var snapshot = NSDiffableDataSourceSnapshot<Section, CurrencyRate>()
                snapshot.appendSections([.main])
                snapshot.appendItems(conversions)
                self?.dataSource.apply(snapshot, animatingDifferences: true)
            }
            .store(in: &cancellables)
    }
}


// MARK: - TextField -
extension CurrencyViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let amount = Double(textField.text ?? "0.0") ?? 0.0
        if  amount != 0.0 {
            viewModel.setSelectedCurrency(currency:selectedCurrencyLabel.text)
            collectionView.reloadData()
        }
        return true
    }
}

extension CurrencyViewController: CurrencySelectionDelegate {
    
    func didSelectCurrency(currency: CurrencyDetail) {        
        viewModel.setSelectedCurrency(currency: currency.value)
        selectedCurrencyLabel.text = currency.name
        collectionView.reloadData()
    }
}
