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
import FirebaseAuth

class LoginVC: UIViewController, UITextFieldDelegate {
    // Outlets
    @IBOutlet weak var userTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
   
    
    // Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITextField.appearance().tintColor = UIColor(red: 13/255, green: 62/255, blue: 108/255, alpha: 1)
        userTxtField.delegate = self
        passwordTxtField.delegate = self
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if Auth.auth().currentUser != nil {
                self.performSegue(withIdentifier: SEGUE_TO_USER_ACCOUNTS, sender: nil)
            } else {
                print("Please sign up")
            }
        }
    }
    
    // Actions
    @IBAction func loginBtnPressed(_ sender: Any) {
        guard let email = userTxtField.text, userTxtField.text != nil else { return }
        guard let password = passwordTxtField.text, passwordTxtField.text != nil else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                if email == "" && password == "" {
                    let alert = UIAlertController(title: "Heads Up!", message: "Please enter a username and password", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(alertAction)
                    self.present(alert, animated: true, completion: nil)
                } else if let errorCode = AuthErrorCode(rawValue: (error! as NSError).code) {
                    let alert = UIAlertController(title: "Heads Up!", message: errorCode.errorMessage, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(alertAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.userTxtField.text = ""
                    self.passwordTxtField.text = ""
                    self.performSegue(withIdentifier: SEGUE_TO_USER_ACCOUNTS, sender: nil)
                }
            }
        }
    }
    
    @IBAction func resetPasswordBtnPressed(_ sender: Any) {
        let modalVC = ResetPasswordModal()
        modalVC.modalPresentationStyle = .custom
        modalVC.modalTransitionStyle = .crossDissolve
        present(modalVC, animated: true, completion: nil)
    }
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: SEGUE_TO_SIGNUP_VC, sender: nil)
        userTxtField.text = ""
        passwordTxtField.text = ""
    }
    
    
    @IBAction func unwindToLoginVC(segue: UIStoryboardSegue) {
        
    }
   
    
    // Protocol Conformation Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case userTxtField:
            passwordTxtField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
    
}
