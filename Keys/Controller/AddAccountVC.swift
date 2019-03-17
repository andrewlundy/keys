//
//  AddAccountVC.swift
//  Keys
//
//  Created by Andrew Lundy on 3/15/19.
//  Copyright © 2019 Andrew Lundy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class AddAccountVC: UIViewController {

    @IBOutlet weak var accountNameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func addAccountBtnPressed(_ sender: Any) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        guard let accountName = accountNameTxtField.text, accountNameTxtField.text !=  nil else { return }
        guard let email = emailTxtField.text, emailTxtField.text != nil else { return }
        guard let password = passwordTxtField.text, passwordTxtField.text != nil else { return }
        
        self.ref.child("users/\(userId)/accounts/\(accountName)/email").setValue(email)
        self.ref.child("users/\(userId)/accounts/\(accountName)/password").setValue(password)
        
        accountNameTxtField.text = ""
        emailTxtField.text = ""
        passwordTxtField.text = ""
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
