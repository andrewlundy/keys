//
//  LoginVC.swift
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
    @IBOutlet weak var passwordTxtField: UITextField!
    
    let ref = Database.database().reference(withPath: "users")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
    }
    
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func demoBtnPressed(_ sender: Any) {
        
    }
    
    func setupView() {
        userTxtField.attributedPlaceholder = NSAttributedString(string: "user", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        passwordTxtField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)])
    }

}
