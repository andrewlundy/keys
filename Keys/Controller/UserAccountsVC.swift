//
//  UserAccountsVC.swift
//  Keys
//
//  Created by Andrew Lundy on 3/11/19.
//  Copyright © 2019 Andrew Lundy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseDatabase
import FirebaseAuth

class UserAccountsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var usernameLbl: UIBarButtonItem!
    
    
    // Variables
    var ref = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    let userRef = Database.database().reference(withPath: "users/\(Auth.auth().currentUser!.uid)/accounts")
    var accounts: [UserAccount] = []
    let noAccountsLbl = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 25))

    
    // Firestore Variables
    let fireStoreDb = Firestore.firestore()
    
    
    
    // Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        self.tableView.tableFooterView = UIView()
        let newRef = fireStoreDb.collection("users").document("\(userID!)")
        
        // Update username label
        newRef.getDocument { (document, error) in
            if let newUser = document.flatMap({ ($0.data()).flatMap({ (data) -> FirestoreUser? in
                return FirestoreUser(dictionary: data)
            })
            })  {
                self.usernameLbl.title = newUser.name
            } else {
                print("Document does not exist.")
            }
        }
       
      
        
        usernameLbl.target = nil
        tableView.delegate = self
        tableView.dataSource = self
        
        usernameLbl.title = ""
        
        noAccountsLbl.isHidden = false
        noAccountsLbl.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        noAccountsLbl.text = "No accounts to display"
        noAccountsLbl.textAlignment = .center
        
        self.view.addSubview(noAccountsLbl)
        
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        // Listen for change of value in the user's account
        fireStoreDb.collection("users").document("\(userID!)").collection("Accounts").addSnapshotListener { (snapshot, error) in
            guard let document = snapshot else {
                print("There was an error fetching document: \(error!)")
                return
            }
            // Get documents when there is a change in data
            self.fireStoreDb.collection("users").document(self.userID!).collection("Accounts").getDocuments { (snapshot, error) in
                var newAccounts: [UserAccount] = []
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in snapshot!.documents {
                        if let childData = document.data() as? [String: Any] {
                            let name = childData["accountName"] as? String ?? ""
                            let username = childData["username"] as? String ?? ""
                            let email = childData["email"] as? String ?? ""
                            let password = childData["password"] as? String ?? ""
                            let newAccount = UserAccount(name: name, email: email, password: password, username: username)
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
        
        }
    }
    
    
    // Actions
    @IBAction func logoutBtnPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch {
            debugPrint("No")
        }
        
    }

    @IBAction func addBtnPressed(_ sender: Any) {
        showModal()
    }
    
    
    func showModal() {
        let modalVC = AddAccountVC()
        modalVC.modalTransitionStyle = .crossDissolve
        modalVC.modalPresentationStyle = .custom
        present(modalVC, animated: true, completion: nil)
        
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
            // Delete account in Firestore path
            fireStoreDb.collection("users").document(userID!).collection("Accounts").document("\(account.name)").delete()
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TO_FULL_ACCOUNT_VIEW {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let accountDetails = segue.destination as! AccountDetailsVC
                accountDetails.account = accounts[indexPath.row]
//                accountDetails.title = accounts[indexPath.row].name
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: TO_FULL_ACCOUNT_VIEW, sender: nil)
    }
    
    
}


