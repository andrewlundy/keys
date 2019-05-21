//
//  SignUpViewController.swift
//  Keys
//
//  Created by Andrew Lundy on 3/14/19.
//  Copyright © 2019 Andrew Lundy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseDatabase
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {
    // Outlets
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
    // Variables
    var ref = Database.database().reference()
    
    // Firestore Variables
    let fireStoreDb = Firestore.firestore()
    
    // Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTxtField.delegate = self
        emailTxtField.delegate = self
        passwordTxtField.delegate = self
        activitySpinner.isHidden = true
    }
    
    // Actions
    @IBAction func continueBtnPressed(_ sender: Any) {
        guard let emailTxt = emailTxtField.text, emailTxtField.text != nil else { return }
        guard let passwordTxt = passwordTxtField.text, passwordTxtField.text != nil else { return }
        
        activitySpinner.startAnimating()
        activitySpinner.isHidden = false
        
        Auth.auth().createUser(withEmail: emailTxt, password: passwordTxt) { (authResult, error) in
            if error != nil {
                self.activitySpinner.stopAnimating()
                self.activitySpinner.isHidden = true
                if let errorCode = AuthErrorCode(rawValue: (error! as NSError).code) {
                    let alert = UIAlertController(title: "Hold Up!", message: errorCode.errorMessage, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okayAction)
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            
            Auth.auth().signIn(withEmail: emailTxt, password: passwordTxt, completion: { (authResult, error) in
                if error == nil {
                    let username = self.nameTxtField.text
//                    self.ref.child("users").child(Auth.auth().currentUser!.uid).setValue(["username": username])
                    self.fireStoreDb.collection("users").document("\(Auth.auth().currentUser!.uid)").setData([
                        "userName": username,
                        "UID": Auth.auth().currentUser!.uid
                        ], completion: { (error) in
                            if let error = error {
                                print("Error adding document: \(error)")
                            } else {
                                print("New user added.")
                            }
                    })
                    
                    
                    self.activitySpinner.isHidden = true
                    self.activitySpinner.stopAnimating()
                    self.nameTxtField.text = ""
                    self.passwordTxtField.text = ""
                    self.emailTxtField.text = ""
                    self.performSegue(withIdentifier: SEGUE_TO_USER_ACCOUNTS, sender: nil)
                } else {
                    debugPrint(error as Any)
                }
            })
        }
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        
    }
    
    // Protocol Conformation Functions
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTxtField:
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




// Extend off of the Firebase AuthErrorCode and set errorMessage to be returned depending on what error occurs
extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account"
        case .userNotFound:
            return "No account found with the provided email address. Please check and try again"
        case .userDisabled:
            return "Your account has been disabled. Please contact support."
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "Please enter a valid email"
        case .networkError:
            return "Network error. Please try again."
        case .weakPassword:
            return "Your password is too weak. The password must be 6 characters long or more."
        case .wrongPassword:
            return "Your password is incorrect. Please try again or use 'Forgot password' to reset your password"
        default:
            return "Unknown error occurred"
        }
    }
}
