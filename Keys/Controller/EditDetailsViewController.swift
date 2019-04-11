//
//  EditDetailsViewController.swift
//  Keys
//
//  Created by Andrew Lundy on 4/7/19.
//  Copyright © 2019 Andrew Lundy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class EditDetailsViewController: UIViewController, UITextFieldDelegate {

    var account: UserAccount! = nil
    var userRef: DatabaseReference?
    
    
    @IBOutlet weak var accountNameLbl: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var notesTxtField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.placeholder = account.email
        passwordTxtField.placeholder = account.password
        notesTxtField.text = account.notes
        emailTextField.becomeFirstResponder()
        print("EDIT ACCOUNT")
        let newId = Auth.auth().currentUser?.uid
        userRef = Database.database().reference(withPath: "users/\(newId!)/accounts/\(account.name)")
//        print(userRef!)
//        print(Auth.auth().currentUser!.uid)
//        print(account.email)
        
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_ACCOUNT_DETAILS, sender: nil)
        print("Unwind perform")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == UNWIND_TO_ACCOUNT_DETAILS {
            let accountDetailsVC = segue.destination as! AccountDetailsVC
            accountDetailsVC.account = account
            accountDetailsVC.emailAddress = emailTextField.text
            accountDetailsVC.tableView.reloadData()
            print(accountDetailsVC.account.email)
        }
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        if emailTextField.text != nil {
            let newEmail = emailTextField.text as! String
            userRef?.child("email").setValue(newEmail)
            account.email = newEmail
        }
        
        
        if passwordTxtField.text == "" && passwordTxtField.placeholder != nil {
            let newPass = passwordTxtField.placeholder
            userRef?.child("password").setValue(newPass)
        } else if passwordTxtField.text != nil {
            let newPass = passwordTxtField.text
            userRef?.child("password").setValue(newPass)
        }
      
    }


}
