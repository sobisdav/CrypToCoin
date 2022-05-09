//
//  ViewController.swift
//  CrypToCoin
//
//  Created by David Sobíšek on 07.04.2022.
//

import UIKit
import Firebase

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var model = [CryptoData]()
    var cryptoName: String!
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        navigationItem.hidesBackButton = true
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
            // swiftlint:disable force_cast
            let destinationVC = segue.destination as! DetailViewController
            // swiftlint:enable force_cast
            destinationVC.cryptoName = cryptoName
        }
    }
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = model[indexPath.row].name
        content.textProperties.alignment = .center
        content.textProperties.adjustsFontSizeToFitWidth = true
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 25)
        content.textProperties.color = UIColor.darkGray
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cryptoName = model[indexPath.row].name
        self.performSegue(withIdentifier: "goToDetail", sender: self)
    }
}
