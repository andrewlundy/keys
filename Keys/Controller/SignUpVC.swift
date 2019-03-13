//
//  SignUpVC.swift
//  Keys
//
//  Created by Andrew Lundy on 3/8/19.
//  Copyright © 2019 Andrew Lundy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class SignUpVC: UIViewController {

    var ref: DatabaseReference!
    
    
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        ref = Database.database().reference(withPath: "users")
        Auth.auth().addStateDidChangeListener({ (auth, user) in
            if user != nil {
                self.dismiss(animated: true, completion: nil)
                
                self.presentLoginController()
            }
        })
    }
    

    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        guard let usernameTxt = usernameTxtField.text, usernameTxtField.text != nil else { return }
        guard let passwordTxt = passwordTxtField.text, passwordTxtField.text != nil else { return }
        
        activitySpinner.startAnimating()
        activitySpinner.isHidden = false
        
        Auth.auth().createUser(withEmail: usernameTxt, password: passwordTxt) { (authResult, error) in
            if error != nil {
                self.activitySpinner.stopAnimating()
                self.activitySpinner.isHidden = true
                print((error! as NSError).code)
                if let errorCode = AuthErrorCode(rawValue: (error! as NSError).code) {
                    print(errorCode)
                    let alert = UIAlertController(title: "Hold Up!", message: errorCode.errorMessage, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okayAction)
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            Auth.auth().signIn(withEmail: usernameTxt, password: passwordTxt, completion: { (authResult, error) in
                if error == nil {
                    self.activitySpinner.isHidden = true
                    self.activitySpinner.stopAnimating()
                    self.usernameTxtField.text = ""
                    self.passwordTxtField.text = ""
                    self.present(UserAccountsVC(), animated: true, completion: nil)
                } else {
                    debugPrint(error as Any)
                }
            })
        }
    }
    
    func setUpView() {
        activitySpinner.isHidden = true
    }
    
    func presentLoginController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "UserAccountsVC")
        present(controller, animated: true, completion: nil)
    }
}




// Extend off of the Firebase AuthErrorCode and set the message to be returned depending on what error occurs
extension AuthErrorCode {
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "The email is already in use with another account"
        case .userNotFound:
            return "Account not found for the specified user. Please check and try again"
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

extension UIViewController {
    func presentVCFromModal(viewController: UIViewController) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserAccountsVC")
        viewController.present(vc, animated: true, completion: nil)
    }
}



