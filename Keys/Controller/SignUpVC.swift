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
        
        
        
        let user = User(name: usernameTxt, password: passwordTxt)
        let userRef = self.ref.child(usernameTxt.lowercased())
        userRef.setValue(user.toAnyObject())
    }
    
    
    func setUpView() {
        let transition = CATransition()
        transition.duration = 5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.view.layer.add(transition, forKey: nil)
    }
    
    

}
