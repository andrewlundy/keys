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
    @IBOutlet weak var accountImage: SocialIcon!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accountImage.image = UIImage(named: "blankUserIcon")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }

}
