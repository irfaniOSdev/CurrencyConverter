//
//  CurrencyCollectionViewCell.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 29/10/2023.
//

import UIKit

class CurrencyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var exchangeLabel: UILabel!
    
    var currencyRate: CurrencyRate? {
        didSet {
            currencyLabel.text = currencyRate?.name
            exchangeLabel.text = String(format: "%.3f", currencyRate?.value ?? 0.0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 10.0
    }

}
