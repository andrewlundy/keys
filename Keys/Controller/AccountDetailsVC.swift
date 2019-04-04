//
//  AccountDetailsVC.swift
//  Keys
//
//  Created by Andrew Lundy on 3/28/19.
//  Copyright © 2019 Andrew Lundy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class AccountDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var accountNameLbl: UILabel!
    
    
    // Variables
    var account: UserAccount!
    var emailAddress: String!
    let userRef = Database.database().reference(withPath: "users/\(Auth.auth().currentUser!.uid)/accounts")
   
    
    
    // Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editAccountDetails))
        accountNameLbl.text = account.name
        print(account)
    }
    
    @objc func editAccountDetails() {
        let modal = EditAccountDetailsModal()
        modal.modalPresentationStyle = .custom
        modal.modalTransitionStyle = .crossDissolve
        
        present(modal, animated: true)
    }
    
    
    // Protocol Conformation Functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ACCOUNT_DETAIL_CELL_ID) as! AccountDetailsCell
        
        if indexPath.row == 0 {
            cell.detailLbl.text = "Email"
            cell.detailValue.text = account.email
            cell.detailValue.textColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
        } else if indexPath.row == 1 {
            cell.detailLbl.text = "Password"
            cell.detailValue.text = account.password
        } else {
            cell.detailLbl.text = "Notes"
            cell.detailValue.text = ""
        }
        
        return cell
    }

    
   
    
    
  

}
