//
//  MainAccountsListVC.swift
//  Keys
//
//  Created by Andrew Lundy on 6/17/19.
//  Copyright © 2019 Andrew Lundy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseDatabase
import FirebaseAuth

class MainAccountsListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    let account = "Facebook"
    let accountCounts = 5
    
    @IBOutlet weak var usernameLbl: UIBarButtonItem!
    
    // Variables
    let userID = Auth.auth().currentUser?.uid
    var accounts: [UserAccount] = []
    let noAccountsLbl = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 25))
    
    
    // Firestore Variables
    let fireStoreDb = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.reloadData()
        self.tableview.separatorStyle = UITableViewCell.SeparatorStyle.singleLine

        tableview.dataSource = self
        tableview.delegate = self
        let newRef = fireStoreDb.collection("users").document("\(userID!)")
        
        let testRef = fireStoreDb.collection("users").document("\(userID!)").collection("Accounts").document("Instagram").collection("Instagram")
        let query = testRef.whereField("name", isEqualTo: true)
        print(query)
        
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
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "MainAccountCell") as! MainAccountCell
        
        cell.accountCountLbl.text = String(accountCounts)
        cell.accountLogoImg.image = UIImage(named: "\(account.lowercased())Logo")
        cell.accountNameLbl.text = account
        return cell
    }
    

}
