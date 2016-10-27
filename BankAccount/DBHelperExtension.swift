//
//  DBHelperExtension.swift
//  BankAccount
//
//  Created by André Henrique da Silva on 10/20/15.
//  Copyright © 2015 André Henrique da Silva. All rights reserved.
//

import CoreData

extension DBHelper {
    
    func all() -> [Transaction]{

        return all("Transaction", orderBy: "when", ascending: true) as! [Transaction]
    }
    
}
