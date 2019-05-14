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
import FirebaseAuth

class AddAccountVC: UIViewController, UITextFieldDelegate {

    // Outlets
    @IBOutlet weak var accountNameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    // Variables
    let ref = Database.database().reference()
    
    // Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        accountNameTxtField.delegate = self
        emailTxtField.delegate = self
        passwordTxtField.delegate = self
        accountNameTxtField.becomeFirstResponder()
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        
        self.view.addGestureRecognizer(tap)

    }
    
   
    
    
    // Actions
    @IBAction func addAccountBtnPressed(_ sender: Any) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        guard let accountName = accountNameTxtField.text, accountNameTxtField.text !=  nil else { return }
        guard let email = emailTxtField.text, emailTxtField.text != nil else { return }
        guard let password = passwordTxtField.text, passwordTxtField.text != nil else { return }
        
        self.ref.child("users/\(userId)/accounts/\(accountName)/name").setValue(accountName)
        self.ref.child("users/\(userId)/accounts/\(accountName)/email").setValue(email)
        self.ref.child("users/\(userId)/accounts/\(accountName)/password").setValue(password)
    
        accountNameTxtField.text = ""
        emailTxtField.text = ""
        passwordTxtField.text = ""
        
        accountNameTxtField.becomeFirstResponder()
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // Protocol Conformation Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case accountNameTxtField:
            emailTxtField.becomeFirstResponder()
        case emailTxtField:
            passwordTxtField.becomeFirstResponder()
        case passwordTxtField:
            passwordTxtField.resignFirstResponder()
        default:
            resignFirstResponder()
        }
        return true
    }
    
}
