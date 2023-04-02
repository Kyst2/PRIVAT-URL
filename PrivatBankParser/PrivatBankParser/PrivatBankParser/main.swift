//
//  main.swift
//  PrivatBankParser
//
//  Created by Andrew Kuzmich on 01.04.2023.
//

import Foundation

let dateNow = Date.now
let oneDay: TimeInterval = 60 * 60 * 24

let arrOfDates = (0...3)
    .map{ $0 }
    .map{ dateNow.addingTimeInterval( TimeInterval( (Double(oneDay) * Double(-$0)) ) ) }
    .map{ $0.string(withFormat: "dd.MM.yyyy") }

let parser = PrivatBankParser()

let currencies = arrOfDates
                        .compactMap { parser.getCurrencyFor(date: $0) }
                        .compactMap { $0.asCurrencyInfo() }

readLine()

class PrivatBankParser {
    func getCurrencyFor(date: String ) -> BankInfo? {
        let url = "https://api.privatbank.ua/p24api/exchange_rates?json&date=\(date)".asURL()
        
        do {
            let contents = try String(contentsOf: url, encoding: .ascii)
            
            let a = contents.decodeFromJson(type: BankInfo.self)
            
            return try a.get()
        } catch { }
        
        return nil
    }
}

///////////////////////
///HELPERS
///////////////////////

extension String {
    func asURL() -> URL {
        return URL(string: self)!
    }
}




////////////////////////
///GARBAGE
////////////////////////
extension PrivatBankParser {
    
    
//    func getCurrencyFor(date: String) -> BankInfo?  {
//        let session = URLSession.shared
//
//        let url = "https://api.privatbank.ua/p24api/exchange_rates?json&date=\(date)".asURL()
//
//        let a = session
//            .dataTaskPublisher(for: url)
//            .map(\.data)
//            .decode(type: BankInfo.self, decoder: JSONDecoder())
////            .catch({ Just(.failed($0)) })
//            .receive(on: DispatchQueue.main)
//            .values as? BankInfo
////            .assign(to: &$state)
//
//        return a
//    }
    
    
    func getCurrencyFor111(date: String) -> BankInfo? {
        let urlString = "https://api.privatbank.ua/p24api/exchange_rates?json&date=\(date)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return nil
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [self] (data, response, error) in
            if let error = error {
                print("Error retrieving exchange rates: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("Empty response data")
                return
            }
            do {
                if let exchangeRates = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                    self.exchangeRate = exchangeRates
                    
                }
                // Do something with the exchange rates data
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
                return
            }
        }
        task.resume()
        
        return nil
    }
}
