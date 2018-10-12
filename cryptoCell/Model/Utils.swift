//
//  Utils.swift
//  cryptoCell
//
//  Created by HackerU on 03/09/2018.
//  Copyright © 2018 HackerU. All rights reserved.
//

import Foundation

extension Double{
    var stringValue : String{
        get{
            return String(format: "%.2f", self)
        }
    }
    
    var priceString : String?{
        get{
            let formatter = NumberFormatter()
            formatter.currencyCode = "USD"
            formatter.numberStyle = .currency
            
            return formatter.string(from: self as NSNumber)
        }
    }
}
