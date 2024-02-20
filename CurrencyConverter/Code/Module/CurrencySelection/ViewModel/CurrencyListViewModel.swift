//
//  CurrencyListViewModel.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 31/10/2023.
//

import Foundation
import Combine

class CurrencyListViewModel {
 
    @Published private(set) var currencies: [CurrencyDetail] = []

    private var cancellables: Set<AnyCancellable> = []

    private let dataService: CurrencyListService

    // Inject the data service through the initializer
    init(dataService: CurrencyListService) {
        self.dataService = dataService
    }

    func fetchData() {
        
        dataService.performRequest().sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, receiveValue: { [weak self] response in
            guard let self else { return }
            let currencyList = CurrencyList(dictionary: response)
            self.currencies.append(contentsOf: currencyList.getCurrencyList())
        })
        .store(in: &cancellables)
    }

}
