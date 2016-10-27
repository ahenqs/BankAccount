//
//  StatementTableViewCell.swift
//  BankAccount
//
//  Created by André Henrique da Silva on 10/20/15.
//  Copyright © 2015 André Henrique da Silva. All rights reserved.
//

import UIKit

class StatementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureForItem(_ item:Dictionary<String, Double>){
        self.operationLabel.text = item.keys.first
        self.valueLabel.text = String(format: "%.2f", item[item.keys.first!]!)
    }

}
