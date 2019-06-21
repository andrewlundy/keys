//
//  SocialIcon.swift
//  Keys
//
//  Created by Andrew Lundy on 6/6/19.
//  Copyright © 2019 Andrew Lundy. All rights reserved.
//

import UIKit

class SocialIcon: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        updateImage()
    }
    
    func updateImage() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 1
        
    }
}
