//
//  ViewController.swift
//  API Project
//
//  Created by Zoe Berthold on 7/10/18.
//  Copyright © 2018 Zoe Berthold. All rights reserved.
//

import UIKit

class CurrenciesViewController: UITableViewController {

    var currencies = [[String: String]]()
    var typesOfCurrencies = ["USD", "GBP", "EUR"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Currencies"
        let query = "https://api.coindesk.com/v1/bpi/currentprice.json"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                parse(json: json)
                return
            }
        }
        loadError()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func parse (json: JSON){
//        var cool = json["bpi"]
//        var moreCool = cool.dictionaryValue
//        for currency in typesOfCurrencies {
//            var value = moreCool[currency]
//            print(value!)
//        }
        
        for result in typesOfCurrencies{
            var cool = json["bpi"][result]["code"]
            print(cool)
        }
        tableView.reloadData()
    }
    func loadError() {
        let alert = UIAlertController(title: "Loading Error",
                                      message: "There was a problem loading the news feed",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}

