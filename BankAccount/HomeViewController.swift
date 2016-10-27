//
//  ViewController.swift
//  BankAccount
//
//  Created by André Henrique da Silva on 10/19/15.
//  Copyright © 2015 André Henrique da Silva. All rights reserved.
//

import UIKit
import WatchConnectivity

class HomeViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    
    var transactions: Array<Transaction>!
    
    var account: Account!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transactions = DBHelper.sharedInstance.all()
        
        if (self.transactions.count <= 0){
            
            startButton.isHidden = false
            
        } else {
            
            print(self.transactions)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startAccount(_ sender: UIButton) {
        
        if (self.account == nil){
            self.account = Account(balance: 200.0)
            
            print(String(format: ".2f", self.account.available()))
        }
        
    }
    
//    func run() -> Array<Dictionary<String, Double>!> {
//        
//        let bb = Account(balance: 200.0)
//        
//        bb.printStatement()
//        
//        bb.deposit(90.0)
//        bb.withdraw(110.0)
//        bb.printStatement()
//        
//        bb.deposit(350.0)
////        bb.withdraw(200.0)
////        bb.printStatement()
////        
////        
////        bb.deposit(50.0)
////        bb.withdraw(450.0)
////        bb.printStatement()
////        
////        
////        bb.deposit(200.0)
////        bb.withdraw(100.0)
////        bb.printStatement()
////        
////        bb.withdraw(50.0)
////        bb.printStatement()
////        
////        bb.withdraw(400.0)
////        
////        bb.loan(400)
////        
////        bb.printStatement()
//        
//        return bb.statement()
//    }
    
    // MARK: Navigation
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if (segue.identifier == "statement"){
//            
//            let viewController = segue.destinationViewController as! StatementTableViewController
////            viewController.transactions = self.transactions
//            
//        }
//    }
}

