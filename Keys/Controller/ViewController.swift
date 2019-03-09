//
//  ViewController.swift
//  Keys
//
//  Created by Andrew Lundy on 3/8/19.
//  Copyright © 2019 Andrew Lundy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class LoginVC: UIViewController {

    @IBOutlet weak var userTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTxtField.attributedPlaceholder = NSAttributedString(string: "user", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
    }
}

