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

    @IBOutlet weak var userTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
   
    let signUpVC = SignUpVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
    }
    
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        showModal()
    }
    
    @IBAction func demoBtnPressed(_ sender: Any) {
        
    }
    
    func setupView() {
        userTxtField.attributedPlaceholder = NSAttributedString(string: "user", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)])
        passwordTxtField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)])
        let navBarTitle = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = navBarTitle
    }
    
    
    func showModal() {
        signUpVC.modalPresentationStyle = .custom
        signUpVC.modalTransitionStyle = .crossDissolve
        present(signUpVC, animated: true, completion: nil)
    }
    
}
