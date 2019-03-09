//
//  RoundedBlueBtn.swift
//  Keys
//
//  Created by Andrew Lundy on 3/8/19.
//  Copyright © 2019 Andrew Lundy. All rights reserved.
//x

import UIKit

//1
@IBDesignable
class RoundedBlueBtn: UIButton {
    
    //2
    @IBInspectable var buttonColor: UIColor = #colorLiteral(red: 0.05098039216, green: 0.2431372549, blue: 0.4235294118, alpha: 1) {
        didSet {
            layer.backgroundColor = self.buttonColor.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    //3
    override func awakeFromNib() {
        self.updateView()
    }
    
    //4
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.updateView()
    }
    
    //5
    func updateView() {
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = buttonColor
    }

}
