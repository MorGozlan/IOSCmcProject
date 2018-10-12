//
//  CryptoCell.swift
//  cryptoCell
//
//  Created by HackerU on 23/08/2018.
//  Copyright © 2018 HackerU. All rights reserved.
//

import UIKit
import SDWebImage


class CryptoCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView : UIImageView!
    @IBOutlet weak var ranklbl : UILabel!
    @IBOutlet weak var namelbl : UILabel!
    @IBOutlet weak var symbollbl : UILabel!
    @IBOutlet weak var pricelbl : UILabel!
    @IBOutlet weak var change24lbl : UILabel!
    
    
    func setData(_ cryptoData: CryptoData){
        iconImageView.sd_setImage(with: URL(string: cryptoData.imageURLString)!)
        
        ranklbl.text = "\(cryptoData.rank)";
        namelbl.text = "\(cryptoData.name)";
        symbollbl.text = "\(cryptoData.symbolName)"
        pricelbl.text = cryptoData.priceUSD.priceString
        change24lbl.text = cryptoData.change24h.stringValue + "%";
        change24lbl.textColor = cryptoData.change24h < 0 ? UIColor.red : UIColor.green;
        
        
    }
    
}
