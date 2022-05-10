//
//  CoinManager.swift
//  CrypToCoin
//
//  Created by David Sobíšek on 11.04.2022.
//

import Foundation

protocol CoinManagerDelegate: AnyObject {
    func didUpdatePrice (price: Double)
    func didFailWithError (error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let coinCurrencies = ["AUD", "BRL", "CAD", "CNY", "EUR", "GBP", "HKD", "IDR", "ILS", "INR", "JPY", "MXN", "NOK", "NZD", "PLN", "RON", "RUB", "SEK", "SGD", "USD", "ZAR"]
    let cryptoCurrencies = ["BTC", "ETH", "BNB", "LTC", "SOL", "MKR", "BCH", "DOGE"]
    
    func buildURL (from firstCurrency: String, to secondCurrency: String) -> String {
        let urlString = "\(Constants.baseURL)/\(firstCurrency)/\(secondCurrency)?apikey=\(Constants.apiKey)"
        return urlString
    }
    
    func getPrice (from firstCurrency: String, to secondCurrency: String) {
        let urlString = buildURL(from: firstCurrency, to: secondCurrency)
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let cryptoPrice = self.parseJSON(safeData) {
                        self.delegate?.didUpdatePrice(price: cryptoPrice)
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
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

}
