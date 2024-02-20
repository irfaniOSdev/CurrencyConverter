//
//  CurrencyAmountTextField.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 01/11/2023.
//

import UIKit

class CurrencyAmountTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        keyboardType = .decimalPad
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange() {
        if let text = text {
            let filteredText = text.filter { "0123456789-.".contains($0) }
            let components = filteredText.components(separatedBy: ".")
            
            // Ensure there's only one dot in the text.
            if components.count > 2 {
                // If there are multiple dots, remove the extras.
                let wholePart = components[0]
                let fractionalPart = components[1..<components.endIndex].joined()
                self.text = wholePart + "." + fractionalPart
            }
            
            if text != filteredText {
                self.text = filteredText
            }
        }
    }
    
    override func deleteBackward() {
        if let text = text, !text.isEmpty {
            super.deleteBackward()
        }
    }
}
