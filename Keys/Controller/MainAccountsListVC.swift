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
    @IBOutlet weak var usernameLbl: UIBarButtonItem!
    
    // Variables
    let userID = Auth.auth().currentUser?.uid
    var accounts: [UserAccount] = []
    let noAccountsLbl = UILabel(frame: CGRect(x: 0, y: 0, width: 250, height: 25))
    var documentIDs: [String] = []
   
    let dummyAccount = "Facebook"
    let dummyAccountCount = 5
   
    // Firestore Variables
    let fireStoreDb = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.reloadData()
        self.tableview.separatorStyle = UITableViewCell.SeparatorStyle.singleLine

        tableview.dataSource = self
        tableview.delegate = self
        
        
        
        
        let newRef = fireStoreDb.collection("users").document("\(userID!)")
        fireStoreDb.collection("users").document("\(userID!)").collection("Accounts").getDocuments { (snapshot, error) in
            var newDocumentIDs: [String] = []
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in snapshot!.documents {
                    newDocumentIDs.append(document.documentID)
                }
            }
            self.documentIDs = newDocumentIDs
            self.tableview.reloadData()
        }

        
        
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
        return self.documentIDs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "MainAccountCell") as! MainAccountCell
        let documentName = documentIDs[indexPath.row]
        cell.accountCountLbl.text = String(dummyAccountCount)
        
        if documentName != "" && UIImage(named: "\(documentName.lowercased())Logo") != nil {
            cell.accountLogoImg.image = UIImage(named: "\(documentName.lowercased())Logo")
        } else {
            cell.accountLogoImg.image = UIImage(named: "blankeUserIcon")
        }
        
        cell.accountNameLbl.text = documentName
        return cell
    }
}
