//
//  Configuration.swift
//  CurrencyConverter
//
//  Created by Muhammad Irfan on 29/10/2023.
//

import Foundation
import UIKit


let appDelegate = UIApplication.shared.delegate as! AppDelegate

let baseUrl = "https://openexchangerates.org/api/"

let apiAccessKey = ""  // enter your own api key from openexchangerates

let baseCurrency = "USD"

let currencyRefreshRate: TimeInterval = 1800 //30 minutes
 
