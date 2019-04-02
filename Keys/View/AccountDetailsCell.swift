//
//  AccountDetailsCell.swift
//  Keys
//
//  Created by Andrew Lundy on 3/30/19.
//  Copyright © 2019 Andrew Lundy. All rights reserved.
//

import UIKit

class AccountDetailsCell: UITableViewCell {

    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var detailValue: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
