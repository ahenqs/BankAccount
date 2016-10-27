//
//  StatementTableViewController.swift
//  BankAccount
//
//  Created by André Henrique da Silva on 10/20/15.
//  Copyright © 2015 André Henrique da Silva. All rights reserved.
//

import UIKit
import WatchConnectivity

class StatementTableViewController: UITableViewController {
    
    var dataSource: TableViewDataSource?
    var transactions: Array<Dictionary<String, Double>?> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshTableView()
        
        let transferButton = UIBarButtonItem(title: "Transfer $ 100.00", style: .plain, target: self, action: #selector(StatementTableViewController.transferTapped(_:)))
        self.navigationItem.rightBarButtonItem = transferButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshTableView(){
        
        self.dataSource = TableViewDataSource(items: self.transactions as NSArray, cellIdentifier: "cell", configureBlock: { (cell, item) -> () in
            
            if let actualCell = cell as? StatementTableViewCell {
                if let actualItem = item as? Dictionary<String, Double> {
                    actualCell.configureForItem(actualItem)
                }
            }
            
        })
        
        self.tableView.dataSource = self.dataSource
        
        self.tableView.reloadData()
            
    }
    
    @IBAction func transferTapped(_ sender: AnyObject){
        
        self.transactions.append(["Transfer": 100.0])
        
        refreshTableView()
    }
}
