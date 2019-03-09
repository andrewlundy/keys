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
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        ref = Database.database().reference(withPath: "users")
    }
    

    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        guard let usernameTxt = usernameTxtField.text, usernameTxtField.text != nil else { return }
        guard let passwordTxt = passwordTxtField.text, passwordTxtField.text != nil else { return }
        
        Auth.auth().createUser(withEmail: usernameTxt, password: passwordTxt) { (authResult, error) in
            if error != nil {
                print(error!._code)
                self.handleError(error!)
                return
            }
        }
    }
    
    
    func setUpView() {
        let transition = CATransition()
        transition.duration = 5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.view.layer.add(transition, forKey: nil)
    }
    
    

}

// Extending off of the Firebase AuthErrorCode and setting the message to be returned depending on what error occurs
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
    func handleError(_ error: Error) {
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            print(errorCode.errorMessage)
            let alert = UIAlertController(title: "Hold Up!", message: errorCode.errorMessage, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(okAction)
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
}
