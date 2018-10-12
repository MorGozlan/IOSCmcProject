//
//  CMCManager.swift
//  cryptoCell
//
//  Created by HackerU on 03/09/2018.
//  Copyright © 2018 HackerU. All rights reserved.
//

import Foundation

class CMCManager : NSObject{
    
    static let manager = CMCManager()
    
    private let baseUrl = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=5000"
    typealias CryptoDataCallback = ([CryptoData]) -> Void
    
    private let cmcPrivateKey = "8bb92dd3-e694-4cc4-8ee2-f79c9093b633"
    
    func getCryptoData(with callback : @escaping CryptoDataCallback)
    {
        guard let url = URL(string: baseUrl) else{
            callback([])
            return
        }
        
        var req = URLRequest(url: url)
        req.addValue(cmcPrivateKey, forHTTPHeaderField: "X-CMC_PRO_API_KEY");
        
        URLSession.shared.dataTask(with: req, completionHandler: {d,r,e in
            
            AsyncTask(backgroundTask: {(req:Data)->[CryptoData] in
                guard let jsonObj = try? JSONSerialization.jsonObject(with: d!, options: .mutableContainers),
                    let json = jsonObj as? [String:Any],
                    let rawData = json["data"] as? [[String:Any]]
                    else{
                        return []
                }
                
                return rawData.flatMap{CryptoData($0)}
                
            }, afterTask: {arr in
                callback(arr)
            }).execute(d!);
        }).resume();
    }
    
        
}
