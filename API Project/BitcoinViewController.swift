//
//  ViewController.swift
//  API Project
//
//  Created by Zoe Berthold on 7/10/18.
//  Copyright © 2018 Zoe Berthold. All rights reserved.
//

import UIKit

class BitcoinViewController: UITableViewController {
    
    var bitcoins = [[String: String]]()
    var currency = [String: String]()
    var typesOfCurrencies = ["USD", "GBP", "EUR"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currency["name"]!)
        self.title = "Current Rates"
        let query = "https://api.coindesk.com/v1/bpi/currentprice/\(currency["name"]!).json"
        print(query)
        if let url = URL(string: query) {
            print("the second thing is the problem")
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                parse(json: json)
                return
            }
        }
        else{
            print("you already know who it is")
        }
        loadError()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func parse (json: JSON){
        var rate = ""
        rate = json["bpi"][currency["name"]!]["rate"].stringValue
        currency = ["rate": rate]
        bitcoins.append(currency)
        tableView.reloadData()
    }
    
    func loadError() {
        let alert = UIAlertController(title: "Loading Error",
                                      message: "There was a problem loading the news feed",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bitcoins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let bitcoin = bitcoins[indexPath.row]
        cell.textLabel?.text = bitcoin["rate"]
        return cell
    }
}

