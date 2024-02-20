//
//  Spinner.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 29/10/2023.
//

import SVProgressHUD

protocol SpinnerProtocol {
    static func start()
    static func stop()
}

struct Spinner: SpinnerProtocol {
    
    static func start()  {
        SVProgressHUD.show()
    }
    
    static func stop() {
        SVProgressHUD.dismiss()
    }
}
