//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "8BA48267-7E84-4E86-9F72-406B223051D1"
    var delegate: CoinManagerDelegate?
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String){
        let url = URL(string: baseURL + "/\(currency)?apikey=\(apiKey)")
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url!) {(data, response, error) in
            if error != nil {
                print(error)
                return
            }
            if let safeData = data {
                if let rate = parseJSON(safeData) {
                    self.delegate?.didUpdateRate(coinManager: self, rate: rate)
                }
            }
            
        }
        task.resume()
        
    }
    
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RateModel.self, from: data)
            let rate = decodedData.rate
            print(rate)
            
            return rate
        } catch {
            print(error)
            return nil
        }
    }
}

protocol CoinManagerDelegate {
    func didUpdateRate(coinManager: CoinManager, rate: Double)
}
