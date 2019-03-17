//
//  ModalView.swift
//  Keys
//
//  Created by Andrew Lundy on 3/9/19.
//  Copyright © 2019 Andrew Lundy. All rights reserved.
//

import UIKit

@IBDesignable
class ModalView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }

    
    func setUpView() {
        self.layer.cornerRadius = cornerRadius
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
}
