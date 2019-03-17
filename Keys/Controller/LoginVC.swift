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
    // Outlets
    @IBOutlet weak var userTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
   
    
    // Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user == Auth.auth().currentUser {
                self.performSegue(withIdentifier: SEGUE_TO_USER_ACCOUNTS, sender: nil)
            } else {
                let alert = UIAlertController(title: "Heads Up!", message: "Please enter your email and password", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: SEGUE_TO_SIGNUP_VC, sender: nil)
    }
    
    @IBAction func demoBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func unwindToLoginVC(segue: UIStoryboardSegue) {
        
    }
    
    // Swift Functions
    func setupView() {
        userTxtField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)])
        passwordTxtField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)])
//        let navBarTitle = [NSAttributedString.Key.foregroundColor:UIColor.white]
//        navigationController?.navigationBar.titleTextAttributes = navBarTitle
    }
}
