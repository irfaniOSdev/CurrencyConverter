//
//  CurrencyCodeTableViewCell.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 31/10/2023.
//

import UIKit

class CurrencyCodeTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyLabel: UILabel!
    
    var name: String? {
        didSet {
            currencyLabel.text = name
        }
    }
}
