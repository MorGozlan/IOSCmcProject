//
//  APIManager.swift
//  iFit
//
//  Created by Benny Davidovitz on 27/08/2018.
//  Copyright © 2018 nastya. All rights reserved.
//

import Foundation
import Alamofire

class APIManager : NSObject{
    
    static let manager = APIManager()
    
    //private let appId = "f085f6ec"
    private let appKey = "8bb92dd3-e694-4cc4-8ee2-f79c9093b633"
    private let baseURL = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest"
    private var headerParams : [String:String]{
        get{
            return [
                //"x-app-id":appId,
                "X-CMC_PRO_API_KEY":appKey
            ]
        }
    }
    
    //This method retrive query params to search in the server
    //Return (async, in callback) Array of Food Objects, or Error
    func searchFood(with query : String, callback : @escaping ([Food],Error?)->Void)
    {
        let url = baseURL + "search/instant"
        let queryParams : [String:Any] = [
            "query":query
        ]
        
        Alamofire.request(url, method: .get, parameters: queryParams, headers: headerParams).responseJSON { (dataResponse) in
            
            guard let json = dataResponse.result.value as? [String:Any] else{
                callback([],dataResponse.result.error)
                return
            }
            
            //array of dictionaries , which is value of key "branded"
            let rawArray = json["branded"] as? [[String:Any]] ?? []
            let foodArray = rawArray.compactMap{ Food($0) }

            callback(foodArray,nil)
            //          just like writing the next code:
            
//            var foodArray : [Food] = []
//            for dict in rawArray{
//                if let food = Food(dict){
//                    foodArray.append(food)
//                }
//            }
            
            
        }
    }
    
    
}















