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
        for result in typesOfCurrencies{
            var name = json["bpi"][result]["code"].stringValue
            var description = json["bpi"][result]["description"].stringValue
            let currency = ["name": name, "description": description]
            currencies.append(currency)
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let currency = currencies[indexPath.row]
        cell.textLabel?.text = currency["name"]
        cell.detailTextLabel?.text = currency["description"]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! BitcoinViewController
        let index = tableView.indexPathForSelectedRow?.row
        dvc.currency = currencies[index!]
    }

}

