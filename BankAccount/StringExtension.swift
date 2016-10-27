//
//  StringExtension.swift
//  BankAccount
//
//  Created by André Henrique da Silva on 10/12/15.
//  Copyright © 2015 André Henrique da Silva. All rights reserved.
//

import Foundation

extension String {
    
    public func toDate() -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.date(from: self)
        
    }
}
