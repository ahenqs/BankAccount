//
//  Transaction.swift
//  BankAccount
//
//  Created by André Henrique da Silva on 10/20/15.
//  Copyright © 2015 André Henrique da Silva. All rights reserved.
//

import UIKit
import CoreData

class Transaction: NSManagedObject {
    
    @NSManaged var transaction: String
    @NSManaged var value: Double
    @NSManaged var credit: Bool
    @NSManaged var when: Date

    
    override var description: String {
        
        return "Transaction: \(transaction) -> Value: \(value) -> \(credit == true ? "Credit" : "Debit") -> at \(when)"
        
    }
}
