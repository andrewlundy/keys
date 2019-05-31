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
//    var userRef: DatabaseReference?
    var firestoreDb = Firestore.firestore()
    var fireRef: DocumentReference?
    
    
    @IBOutlet weak var accountNameLbl: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var notesTxtField: UITextView!
    @IBOutlet weak var usernameTxtField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountNameLbl.text = account.name
        emailTextField.placeholder = account.email
        passwordTxtField.placeholder = account.password
        notesTxtField.text = account.notes
        usernameTxtField.placeholder = account.username
        emailTextField.becomeFirstResponder()
        let newId = Auth.auth().currentUser?.uid
//        userRef = Database.database().reference(withPath: "users/\(newId!)/accounts/\(account.name)")
        fireRef = firestoreDb.collection("users").document("\(newId!)").collection("Accounts").document(account.name)
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_ACCOUNT_DETAILS, sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == UNWIND_TO_ACCOUNT_DETAILS {
            let accountDetailsVC = segue.destination as! AccountDetailsVC
            accountDetailsVC.account = account
            accountDetailsVC.emailAddress = emailTextField.text
            accountDetailsVC.tableView.reloadData()
        }
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
       
        // Check and update email
        if emailTextField.text != nil {
            let newEmail = emailTextField.text! as String
            fireRef?.updateData([
                "email" : newEmail
            ])
            account.email = newEmail
        }
        
        if emailTextField.text == nil && emailTextField.placeholder != nil || emailTextField.text == "" && emailTextField.placeholder != nil {
            let oldEmail = emailTextField.placeholder! as String
            fireRef?.updateData([
                "email": emailTextField.placeholder! as String
            ])
            account.email = oldEmail
        }
        
   
        // Check and update username
        if usernameTxtField.text != nil {
            let newUsername = usernameTxtField.text!
            fireRef?.updateData([
                "username" : newUsername
            ])
            account.username = newUsername
        } else {
            fireRef?.updateData([
                "username" : "No username"
            ])
        }
        
        
        // Check and update password
        if passwordTxtField.text == "" && passwordTxtField.placeholder != nil {
            let newPass = passwordTxtField.placeholder! as String
            fireRef?.updateData([
                "password": newPass
            ])
            account.password = newPass
        } else if passwordTxtField.text != nil {
            let newPass = passwordTxtField.text! as String
            fireRef?.updateData([
                "password": newPass
            ])
            account.password = newPass
        }
        
        
        // Check and update notes
        if notesTxtField.text == "" {
            let newNotes = notesTxtField.text! as String
            fireRef?.updateData([
                "notes" : newNotes
            ])
            account.notes = newNotes
        }
        
//        if emailTextField.text != nil {
//            let newEmail = emailTextField.text as! String
//            userRef?.child("email").setValue(newEmail)
//            account.email = newEmail
//        }
//
//        if passwordTxtField.text == "" && passwordTxtField.placeholder != nil {
//            let newPass = passwordTxtField.placeholder
//            userRef?.child("password").setValue(newPass)
//        } else if passwordTxtField.text != nil {
//            let newPass = passwordTxtField.text! as String
//            userRef?.child("password").setValue(newPass)
//            account.password = newPass
//        }
//
//        if notesTxtField.text == "" {
//            let newNotes = notesTxtField.text! as String
//            userRef?.child("notes").setValue(newNotes)
//            account.notes = newNotes
//        }
        performSegue(withIdentifier: UNWIND_TO_ACCOUNT_DETAILS, sender: nil)
    }


}
