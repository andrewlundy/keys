//
//  UserAccountsVC.swift
//  Keys
//
//  Created by Andrew Lundy on 3/11/19.
//  Copyright © 2019 Andrew Lundy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class UserAccountsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    

    @IBAction func logoutBtnPressed(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
            print(Auth.auth().currentUser?.email)
        } catch {
            debugPrint("No")
        }
        
    }

    
 
 

}
