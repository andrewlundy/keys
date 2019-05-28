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
    var firestoreDb = Firestore.firestore()
    var fireRef: DocumentReference?
    
    
    @IBOutlet weak var accountNameLbl: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var notesTxtField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountNameLbl.text = account.name
        emailTextField.placeholder = account.email
        passwordTxtField.placeholder = account.password
        notesTxtField.text = account.notes
        emailTextField.becomeFirstResponder()
        let newId = Auth.auth().currentUser?.uid
        userRef = Database.database().reference(withPath: "users/\(newId!)/accounts/\(account.name)")
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
        if emailTextField.text != nil {
            let newEmail = emailTextField.text! as String
            fireRef?.updateData ([
                "email": newEmail
            ])
            account.email = newEmail
        }
        
        if passwordTxtField.text == "" && passwordTxtField.placeholder != nil {
            let newPass = passwordTxtField.placeholder! as String
            fireRef?.updateData([
                "password": newPass
            ]) { error in
                if let error = error {
                    print("Error updating document: \(error)")
                } else {
                    print("Document updated!")
                }
            }
            account.password = newPass
        } else if passwordTxtField.text != nil {
            let newPass = passwordTxtField.text! as String
            fireRef?.updateData([
                "password": newPass
            ])
            account.password = newPass
        }
        
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
        dismiss(animated: true, completion: nil)
    }


}
