import Foundation

struct CurrencyInfo {
    let date: Date
    let usdRatePurchase: Double
    let usdRateSell: Double
}

extension BankInfo {
    func asCurrencyInfo() -> CurrencyInfo? {
        if let date = DateFormatter.shared.getDateCustom(strDate: self.date, withFormat: "dd.MM.yyyy"),
           let usd = self.exchangeRate.filter({ $0.currency == "USD" }).first,
           let usdRatePurchase = usd.purchaseRate,
           let usdRateSell = usd.saleRate
        {
            return CurrencyInfo(date: date, usdRatePurchase: usdRatePurchase, usdRateSell: usdRateSell)
        }
        
        return nil
    }
}



struct BankInfo: Codable {
    let date: String
    let bank: String
    let baseCurrency: Int
    let baseCurrencyLit: String
    let exchangeRate: [ExchangeRate]
}

struct ExchangeRate: Codable {// Hashable
    let baseCurrency: String
    let currency: String
    let saleRateNB: Double
    let purchaseRateNB: Double
    let saleRate: Double?
    let purchaseRate: Double?
}




/*
{"date":"20.02.2020","bank":"PB","baseCurrency":980,"baseCurrencyLit":"UAH","exchangeRate":[{"baseCurrency":"UAH","currency":"AUD","saleRateNB":16.4010000,"purchaseRateNB":16.4010000},{"baseCurrency":"UAH","currency":"AZN","saleRateNB":14.4423000,"purchaseRateNB":14.4423000},{"baseCurrency":"UAH","currency":"BYN","saleRateNB":11.1206000,"purchaseRateNB":11.1206000},{"baseCurrency":"UAH","currency":"CAD","saleRateNB":18.5437000,"purchaseRateNB":18.5437000},{"baseCurrency":"UAH","currency":"CHF","saleRateNB":24.9383000,"purchaseRateNB":24.9383000,"saleRate":25.1500000,"purchaseRate":23.4500000},{"baseCurrency":"UAH","currency":"CNY","saleRateNB":3.5062000,"purchaseRateNB":3.5062000},{"baseCurrency":"UAH","currency":"CZK","saleRateNB":1.0612000,"purchaseRateNB":1.0612000,"saleRate":1.0700000,"purchaseRate":0.8900000},{"baseCurrency":"UAH","currency":"DKK","saleRateNB":3.5459000,"purchaseRateNB":3.5459000},{"baseCurrency":"UAH","currency":"EUR","saleRateNB":26.4862000,"purchaseRateNB":26.4862000,"saleRate":26.5300000,"purchaseRate":26.1000000},{"baseCurrency":"UAH","currency":"GBP","saleRateNB":31.8445000,"purchaseRateNB":31.8445000,"saleRate":32.1500000,"purchaseRate":30.3500000},{"baseCurrency":"UAH","currency":"HUF","saleRateNB":0.0787640,"purchaseRateNB":0.0787640},{"baseCurrency":"UAH","currency":"ILS","saleRateNB":7.1676000,"purchaseRateNB":7.1676000},{"baseCurrency":"UAH","currency":"JPY","saleRateNB":0.2217400,"purchaseRateNB":0.2217400},{"baseCurrency":"UAH","currency":"KZT","saleRateNB":0.0651030,"purchaseRateNB":0.0651030},{"baseCurrency":"UAH","currency":"MDL","saleRateNB":1.3900000,"purchaseRateNB":1.3900000},{"baseCurrency":"UAH","currency":"NOK","saleRateNB":2.6440000,"purchaseRateNB":2.6440000},{"baseCurrency":"UAH","currency":"PLN","saleRateNB":6.1983000,"purchaseRateNB":6.1983000,"saleRate":6.2500000,"purchaseRate":5.7500000},{"baseCurrency":"UAH","currency":"SEK","saleRateNB":2.5051000,"purchaseRateNB":2.5051000},{"baseCurrency":"UAH","currency":"SGD","saleRateNB":17.6172000,"purchaseRateNB":17.6172000},{"baseCurrency":"UAH","currency":"TMT","saleRateNB":7.1513000,"purchaseRateNB":7.1513000},{"baseCurrency":"UAH","currency":"TRY","saleRateNB":4.0379000,"purchaseRateNB":4.0379000},{"baseCurrency":"UAH","currency":"UAH","saleRateNB":1.0000000,"purchaseRateNB":1.0000000},{"baseCurrency":"UAH","currency":"USD","saleRateNB":24.5231000,"purchaseRateNB":24.5231000,"saleRate":24.5100000,"purchaseRate":24.2000000},{"baseCurrency":"UAH","currency":"UZS","saleRateNB":0.0026172,"purchaseRateNB":0.0026172},{"baseCurrency":"UAH","currency":"GEL","saleRateNB":8.6712000,"purchaseRateNB":8.6712000}]}
*/
