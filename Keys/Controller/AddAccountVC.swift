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
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var addAccountBtn: RoundedBlueBtn!
    
    
    // Variables
    let ref = Database.database().reference()
    
    let fireStoreDb = Firestore.firestore()
    
    // Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    

   
    // Actions
    @IBAction func addAccountBtnPressed(_ sender: Any) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        guard let accountName = accountNameTxtField.text, accountNameTxtField.text !=  nil else { return }
        guard let email = emailTxtField.text, emailTxtField.text != nil else { return }
        guard let password = passwordTxtField.text, passwordTxtField.text != nil else { return }
        guard var username = usernameTxtField.text, usernameTxtField.text != nil else { return }
        
        if usernameTxtField.text!.isEmpty {
            username = "No username"
        }
     
        fireStoreDb.collection("users").document(userId).collection("Accounts").document(accountName).setData([
            "accountName": accountName,
            "username": username,
            "email": email,
            "password": password
        ]) { error in
            if let error = error {
                print("Error writing to document: \(error)")
            } else {
                print("Write to document was successful.")
            }
        }
    
        accountNameTxtField.text = ""
        usernameTxtField.text = ""
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
            usernameTxtField.becomeFirstResponder()
        case usernameTxtField:
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

    func updateView() {
        accountNameTxtField.delegate = self
        emailTxtField.delegate = self
        passwordTxtField.delegate = self
        usernameTxtField.delegate = self
        accountNameTxtField.becomeFirstResponder()
        self.addAccountBtn.cornerRadius = 14
        
    }
    
    @objc func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
}


