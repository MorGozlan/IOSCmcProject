
import Foundation

class CryptoData {
    let id:Int
    let rank:Int
    let name:String
    let symbolName:String
    let priceUSD:Double
    let priceBTC:Double
    let change24h:Double
    let slug:String
    
    var imageURLString : String{
        get{
            return "https://images.coinviewer.io/currencies/32x32/" + slug + ".png"
        }
    }
    
    var chartURLString : String{
        get{
            return "https://s2.coinmarketcap.com/generated/sparklines/web/7d/usd/\(id).png"
        }
    }
    
    init(_ dict : [String:Any]) {
        self.rank = dict["cmc_rank"] as? Int ?? 0
        self.id  = dict["id"] as? Int ?? 0
        self.name = dict["name"] as? String ?? ""
        self.symbolName = dict["symbol"] as? String ?? ""
        let quote = dict["quote"] as? [String:Any] ?? [:]
        let usdQuote = quote["USD"] as? [String:Any] ?? [:]
        let btcQuote = quote["BTC"] as? [String:Any] ?? [:]
        self.priceUSD = usdQuote["price"] as? Double ?? 0
        self.priceBTC = btcQuote["price"] as? Double ?? 0
        self.change24h = usdQuote["percent_change_24h"] as? Double ?? 0
        self.slug = dict["slug"] as? String ?? ""
    }
}
