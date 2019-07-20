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
   
    let dummyAccountCount = 5
    
    // Firestore Variables
    let fireStoreDb = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.reloadData()
        self.tableview.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        self.tableview.tableFooterView = UIView()
        
        createRightBarBtn()
        
        tableview.dataSource = self
        tableview.delegate = self
        
        
        
        
        let newRef = fireStoreDb.collection("users").document("\(userID!)")
        
        // Get main accounts count
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

        fireStoreDb.collection("users").document("\(userID!)").collection("Accounts").getDocuments { (snapshot, error) in
            for documentID in self.documentIDs {
                self.fireStoreDb.collection("users").document("\(self.userID!)").collection("Accounts").document(documentID).getDocument(completion: { (document, error) in
                    print(document?.data())
                })
            }
        }
        
        // Listen for change of value in the user's account
        fireStoreDb.collection("users").document("\(userID!)").collection("Accounts").addSnapshotListener { (snapshot, error) in
            guard let document = snapshot else {
                print("There was an error fetching document: \(error!)")
                return
            }
            // Get documents when there is a change in data
            self.fireStoreDb.collection("users").document(self.userID!).collection("Accounts").getDocuments { (snapshot, error) in
                var newDocumentIDs: [String] = []
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    for document in snapshot!.documents {
                       newDocumentIDs.append(document.documentID)
                        
                    }
                    self.documentIDs = newDocumentIDs
                    self.tableview.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
                    
                    self.tableview.reloadData()
                }
            }
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
        
//        fireStoreDb.collection("users").document("\(userID!)").collection("Accounts").document("Instagram").getDocument { (document, error) in
//            if let document = document, document.exists {
//                let dataDescription = document.data() as! [String: Any]
//
//
//                for key in dataDescription {
//                    if key.key == "Instagram" {
//                        print(key.value)
//                    }
//
//                }
//            } else {
//                print("Document doesn't exist.")
//            }
//        }

        // Get sub accounts count
        
    }
    
  
    
    func createRightBarBtn() {
        let addAccountBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAccount))
        navigationItem.rightBarButtonItem = addAccountBtn
    }
    
    @objc func addAccount() {
        let addFoldersModal = AddFoldersModal()
        addFoldersModal.modalPresentationStyle = .custom
        addFoldersModal.modalTransitionStyle = .crossDissolve
        present(addFoldersModal, animated: true, completion: {})
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
            cell.accountLogoImg.image = UIImage(named: "blankUserIcon")
        }
        
        cell.accountNameLbl.text = documentName
        return cell
    }
    
   
}
