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
import FirebaseAuth

class UserAccountsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Outlets
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    // Variables
    var ref = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    let userRef = Database.database().reference(withPath: "users/\(Auth.auth().currentUser!.uid)/accounts")
    var accounts: [UserAccount] = []
    let noAccountsLbl = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 25))

    
    // Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        userNameLbl.text = ""
        
        noAccountsLbl.isHidden = false
        noAccountsLbl.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        noAccountsLbl.text = "No accounts to display"
        noAccountsLbl.textAlignment = .center
        
        
        self.view.addSubview(noAccountsLbl)
        
        
        
        // Update username label
        ref.child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let username = value?["username"] as? String ?? ""
            self.userNameLbl.text = username
        }
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        // Listen for change of value in the user's accounts
        userRef.observe(.value) { (snapshot) in
            var newAccounts: [UserAccount] = []
            // Get the value of the data and cast it as a dictionary
            guard let data = snapshot.value as? [String: AnyObject] else { return }
            // Loop through the children of the data above
            for child in data {
                // Check to see if there is child data in the child from above, if so - cast it as a dictionary
                if let childData = child.value as? [String: Any] {
                    let name = childData["name"] as? String ?? ""
                    let email = childData["email"] as? String ?? ""
                    let password = childData["password"] as? String ?? ""
                    var newAccount = UserAccount(name: name, email: email, password: password)
                    newAccount.ref = snapshot.ref
                    newAccounts.append(newAccount)
                }
            }
            self.accounts = newAccounts
            self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
            
            if self.accounts.count > 0 {
                self.noAccountsLbl.isHidden = true
            }
            
            if self.accounts.count == 0 {
                self.noAccountsLbl.isHidden = false
            }
            
            self.tableView.reloadData()
            
            
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
        showModal()
    }
    
    func showModal() {
        let modalVC = AddAccountVC()
        modalVC.modalTransitionStyle = .crossDissolve
        modalVC.modalPresentationStyle = .custom
        present(modalVC, animated: true, completion: nil)
        
    }
    
    @IBAction func unwindFromFullAccount(segue: UIStoryboardSegue) {
        
    }
 
    
    // Protocol Conformation Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ACCOUNT_CELL_ID) as! AccountCell
        let account = accounts[indexPath.row]
        cell.accountNameLbl.text = account.name
        cell.emailAddressLbl.text = account.email
        cell.passwordLbl.text = account.password
        return cell
    }
    
    // Set the cells to be editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Set the editing style of the cells
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let account = accounts[indexPath.row]
            account.ref?.removeValue()
            self.accounts.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            if accounts.count > 0 {
                noAccountsLbl.isHidden = true
            }
            if accounts.count == 0 {
                noAccountsLbl.isHidden = false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: TO_FULL_ACCOUNT_VIEW, sender: self)
    }

}
