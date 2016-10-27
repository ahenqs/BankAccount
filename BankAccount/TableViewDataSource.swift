//
//  TableViewDataSource.swift
//  BankAccount
//
//  Created by André Henrique da Silva on 10/13/15.
//  Copyright © 2015 André Henrique da Silva. All rights reserved.
//

import UIKit

typealias TableViewCellConfigureBlock = (_ cell: UITableViewCell, _ item: AnyObject?) -> ()

class TableViewDataSource: NSObject, UITableViewDataSource {
    
    var items: NSArray = []
    var itemIdentifier: String?
    var configureCellBlock: TableViewCellConfigureBlock?
    
    init(items: NSArray, cellIdentifier: String, configureBlock: @escaping TableViewCellConfigureBlock) {
        self.items = items
        self.itemIdentifier = cellIdentifier
        self.configureCellBlock = configureBlock
        super.init()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.itemIdentifier!, for: indexPath) 
        
        let item: AnyObject = self.itemAtIndexPath(indexPath)
        
        if (self.configureCellBlock != nil){
            self.configureCellBlock!(cell, item)
        }
        
        return cell
    }
    
    func itemAtIndexPath(_ indexPath: IndexPath) -> AnyObject {
        return self.items[(indexPath as NSIndexPath).row] as AnyObject
    }
    
}
