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

    @IBOutlet weak var nameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.setHidesBackButton(true, animated: true)
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
