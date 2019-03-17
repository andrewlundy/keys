//
//  AccountCell.swift
//  Keys
//
//  Created by Andrew Lundy on 3/17/19.
//  Copyright © 2019 Andrew Lundy. All rights reserved.
//

import UIKit

class AccountCell: UITableViewCell {

  
    @IBOutlet weak var accountNameLbl: UILabel!
    @IBOutlet weak var emailAddressLbl: UILabel!
    @IBOutlet weak var passwordLbl: UILabel!
    
 
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
