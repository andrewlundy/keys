//
//  MainAccountCell.swift
//  Keys
//
//  Created by Andrew Lundy on 6/17/19.
//  Copyright © 2019 Andrew Lundy. All rights reserved.
//

import UIKit

class MainAccountCell: UITableViewCell {

    @IBOutlet weak var accountNameLbl: UILabel!
    @IBOutlet weak var accountCountLbl: UILabel!
    @IBOutlet weak var accountLogoImg: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        accountLogoImg.image = UIImage(named: "blankUserIcon")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
