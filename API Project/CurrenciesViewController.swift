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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Currencies"
        let query = "https://api.coindesk.com/v1/bpi/currentprice.json"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

