//
//  NSDateExtension.swift
//  BankAccount
//
//  Created by André Henrique da Silva on 10/12/15.
//  Copyright © 2015 André Henrique da Silva. All rights reserved.
//

import Foundation

extension Date {
    
    public func toString() -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: self)
        
    }
}
