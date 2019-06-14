//
//  ResetPasswordModal.swift
//  Keys
//
//  Created by Andrew Lundy on 3/25/19.
//  Copyright © 2019 Andrew Lundy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class ResetPasswordModal: UIViewController {

    // Outlets
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var resetPassBtn: RoundedBlueBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetBtnPressed(_ sender: Any) {
        guard let email = emailTxtField.text, emailTxtField.text != "" else { return }
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if error != nil {
//                let alert = UIAlertController(title: "Error sending password reset", message: "There was an issue resetting your password, please try again", preferredStyle: .alert)
//                let alertAction = UIAlertAction(title: "OK", style: .default)
//                alert.addAction(alertAction)
//                self.present(alert, animated: true, completion: nil)
                print(error as Any)
            } else {
                print("Email sent")
            }
        }
    }
    
    func updateView() {
        emailTxtField.becomeFirstResponder()
        self.resetPassBtn.cornerRadius = 14
    }
    
}
