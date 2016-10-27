//
//  Account.swift
//  BankAccount
//
//  Created by André Henrique da Silva on 10/19/15.
//  Copyright © 2015 André Henrique da Silva. All rights reserved.
//

import UIKit
import CoreData

enum AllowedTransactions {
    case limit
    case deposit
    case withdraw
    case statement
    case monthly
    case loan
}

class Account: NSObject {
    
    fileprivate var balance: Double!
    fileprivate var limit: Double!
    fileprivate var transactions: Array<Transaction>!
    
    fileprivate var totalWidthdraws: Int = 0
    fileprivate var totalDeposits: Int = 0
    fileprivate var totalPrints: Int = 0
    
    func save(_ transaction: String, value: Double, credit: Bool) {
        
        print("Saving: \(transaction) of \(value) as \(credit == true ? "credit" : "debit")")
        
        let entity = NSEntityDescription.entity(forEntityName: "Transaction", in: DBHelper.sharedInstance.managedObjectContext)
        
        let tr = Transaction(entity: entity!, insertInto: DBHelper.sharedInstance.managedObjectContext)
        
        tr.setValue(transaction, forKey: "transaction")
        tr.setValue(value, forKey: "value")
        tr.setValue(credit, forKey: "credit")
        tr.setValue(Date(), forKey: "when")
        
        _ = DBHelper.sharedInstance.save(tr)
        
    }

    override init() {
        
        super.init()
        
        self.start()
        
    }
    
    init(balance: Double){
        
        super.init()
        
        self.start()
        
        self.deposit(balance)
    }
    
    fileprivate func start() {
        
        self.balance = 0.0
        self.limit = Constants.LimitValue
        
        save("Limit", value: self.limit, credit: true)
        
        self.charge(Constants.MonthlyChargeValue, operation: .monthly)
    }
    
    func limitForAccount() -> Double {
        return self.limit
    }
    
    func available() -> Double {
        
        let trans = DBHelper.sharedInstance.all() as [Transaction]
        
        var total = 0.0
        
        for res in trans {
        
            let credit: Bool = res.value(forKey: "credit") as! Bool
            
            if (credit){
                total = total + (res.value(forKey: "value") as! Double)
            } else {
                total = total - (res.value(forKey: "value") as! Double)
            }
        }

        return total
    }
    
    func deposit(_ amount: Double){
        
        self.log(.deposit, amount: amount, charge: false)
        
        self.totalDeposits += 1
        
        if (self.totalDeposits > Constants.MaxNumberOfDeposits){
            self.charge(Constants.ChargePerDeposit, operation: .deposit)
        }
        
    }
    
    func withdraw(_ amount: Double) -> Bool {
        
        print("Current Balance: $ \(self.balance)")
        
        if (self.available() >= amount){
        
            self.log(.withdraw, amount: amount, charge: false)
            
            self.totalWidthdraws += 1
            
            if (self.totalWidthdraws > Constants.MaxNumberOfWithdraws){
                self.charge(Constants.ChargePerWithdraw, operation: .withdraw)
            }
            
            print("Withdrawed $ \(amount)")
            
            return true
            
        } else {
            return false
        }
    }

    func statement() -> Array<Transaction> {
        
        return DBHelper.sharedInstance.all()
        
    }
    
    func printStatement() {
        for d in self.statement() {
            print(d)
        }
        
        self.totalPrints += 1
        
        if (self.totalPrints > Constants.MaxNumberOfStatements){
            self.charge(Constants.ChargePerStatement, operation: .statement)
        }
        
        print("\n====================================================\n")
    }
    
    func charge(_ amount: Double, operation: AllowedTransactions) {
        
        self.log(operation, amount: amount, charge: true)
        
        print("Charged $ \(amount)")
        
    }
    
    func loan(_ amount: Double) -> Bool {
        if (amount <= Constants.MaxLoanAmount){
            
            self.log(.loan, amount: amount, charge: false)
            
            self.charge(amount * Constants.ChargePerLoanPercentage, operation: .loan)
            
            print("Loaned $ \(amount)")
            
            return true
        } else {

            return false
        }
    }
    
    fileprivate func log(_ operation:AllowedTransactions, amount: Double, charge: Bool) {
        
        var history = ""
        var credit: Bool = true
        
        switch (operation){
        case .limit:
            
            history = "Limit"
            
            break
            
        case .deposit:
            
            history = "Deposit"
            
            break
            
        case .withdraw:
            
            history = "Withdraw"
            credit = false
            
            break
            
        case .statement:
            
            history = "Extra Statement"
            credit = false
            
            break
            
        case .monthly:
            
            history = "Monthly"
            credit = false
            
            break
            
        case .loan:
            
            history = "Loan"
            
            break
        }
        
        if (charge){
            history = "Charge \(history)"
            credit = false
        }
        
        save(history, value: amount, credit: credit)

    }

    func close() {
        
        _ = DBHelper.sharedInstance.removelAll("Transaction")
    }
}
