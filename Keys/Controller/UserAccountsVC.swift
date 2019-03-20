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

//, UITableViewDelegate, UITableViewDataSource
    
    // Outlets
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    
    
    // Variables
    var ref = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    let userRef = Database.database().reference(withPath: "users/\(Auth.auth().currentUser!.uid)/accounts")
    var accounts: [UserAccount] = []
    

    // Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLbl.text = ""
        
        // Update username label
        ref.child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            self.userNameLbl.text = username
        }
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.setHidesBackButton(true, animated: true)
      

        userRef.observe(.value) { (snapshot) in
            print(snapshot.value as Any)
        }
        
        userRef.observe(.value) { (snapshot) in
            var newAccounts: [UserAccount] = []
            for child in snapshot.children {
                if let data = child as? [String: AnyObject] {
                    let name = data["name"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let password = data["password"] as? String ?? ""
                    let newAccount = UserAccount(name: name, email: email, password: password)
                    newAccounts.append(newAccount)
                }
            }
            self.accounts = newAccounts
            print(self.accounts)
        }
    }
    
    
    // Actions
    @IBAction func logoutBtnPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            debugPrint("No")
        }
        
    }


    @IBAction func addAccountBtnPressed(_ sender: Any) {
//        guard let userId = Auth.auth().currentUser?.uid, Auth.auth().currentUser?.uid != nil else { return }
        showModal()
    }
    
    func showModal() {
        let modalVC = AddAccountVC()
        modalVC.modalTransitionStyle = .crossDissolve
        modalVC.modalPresentationStyle = .custom
        present(modalVC, animated: true, completion: nil)
        
    }
 
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }

}
