//
//  ViewController.swift
//  CrypToCoin
//
//  Created by David Sobíšek on 07.04.2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var model = [CryptoData]()
    var cryptoName: String!
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for name in coinManager.cryptoCurrencies {
            let object = CryptoData(name: name)
            model.append(object)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.cryptoName = cryptoName
        }
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource

extension WelcomeViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        var content = cell.defaultContentConfiguration()
        content.text = model[indexPath.row].name
        content.textProperties.alignment = .center
        cell.contentConfiguration = content
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cryptoName = model[indexPath.row].name
        self.performSegue(withIdentifier: "goToDetail", sender: self)
    }
}

