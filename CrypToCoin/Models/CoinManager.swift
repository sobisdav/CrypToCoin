//
//  CoinManager.swift
//  CrypToCoin
//
//  Created by David Sobíšek on 11.04.2022.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice (price: String, currency: String)
    func didFailWithError (error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate"
    let apiKey = "0412637F-C45D-45D0-9A95-C6834CC762D9"
    
    let coinCurrencies = ["AUD","BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let cryptoCurrencies = ["BTC","ETH","BNB","LTC","SOL","MKR","BCH","DOGE"]

    func getCoinPrice (for currency: String) {
        let urlString = "\(baseURL)/\(currency)/USD?apikey=\(apiKey)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let cryptoPrice = self.parseJSON(safeData) {
                        let priceString = String(format: "%.2f", cryptoPrice)
                        self.delegate?.didUpdatePrice(price: priceString, currency: currency)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON (_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            return lastPrice
        }
        catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

}

