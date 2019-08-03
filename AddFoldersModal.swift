//
//  AddFoldersModal.swift
//  
//
//  Created by Andrew Lundy on 7/19/19.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


class AddFoldersModal: UIViewController {
    let fireStoreDb = Firestore.firestore()
    
    var accountRef: DocumentReference!
    
    
    // UI Elements
    let modalView = UIView()
    let modalTitle = UILabel()
    
    let folderNameTxtField = UITextField()
    let folderNameLineView = UIView()
    
    let addBtn = UIButton()
    let closeBtn = UIButton()
    
    let whatsAFolderBtn = UIButton()
    let alert = UIAlertController(title: "What's a Folder?", message: "A folder is a place where you can keep multiple accounts for the same platform. \n\nExample - multiple Facebook logins are stored in one Facebook folder.", preferredStyle: .alert)
    
    @objc func presentAlert() {
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        alert.addAction(UIAlertAction(title: "Got it!", style: .default))
        view.layer.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.15).cgColor
    }
    

    func addSubView() {
        setupModalView()
        setModalViewConstraints()
        setmodalTitleConstraints()
        setFolderNameTextFieldConstraints()
        setLineViewConstraints()
        setupWhatsAFolderConstraints()
        setCloseBtnConstraints()
        setAddBtnConstraints()
    }
    
    
    // UI Element Setups
    func setupModalView() {
        modalView.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
        modalView.layer.cornerRadius = 25
        modalView.layer.masksToBounds = true
        view.addSubview(modalView)
        
        modalTitle.text = "Add a New Folder"
        modalTitle.font = UIFont(name: "Avenir-Heavy", size: 18)
        modalTitle.textAlignment = .center
        modalView.addSubview(modalTitle)
        
        folderNameTxtField.font = UIFont(name: "Avenir-Book", size: 15)
        folderNameTxtField.placeholder = "Folder Name"
        modalView.addSubview(folderNameTxtField)
        
        folderNameLineView.backgroundColor = UIColor(red: 24/255, green: 62/255, blue: 108/255, alpha: 0.7)
        modalView.addSubview(folderNameLineView)
        
        whatsAFolderBtn.setTitle("What's a Folder?", for: .normal)
        whatsAFolderBtn.setTitleColor(UIColor(red: 24/255, green: 61/255, blue: 109/255, alpha: 1), for: .normal)
        whatsAFolderBtn.setTitleColor(UIColor(red: 24/255, green: 61/255, blue: 109/255, alpha: 0.5), for: .highlighted)
        whatsAFolderBtn.titleLabel?.font = UIFont(name: "Avenir-Light", size: 13)
        whatsAFolderBtn.frame = CGRect(x: 15, y: 50, width: 300, height: 30)
        whatsAFolderBtn.addTarget(self, action: #selector(presentAlert), for: .touchUpInside)
        modalView.addSubview(whatsAFolderBtn)
        
        closeBtn.setImage(UIImage(named: "error"), for: .normal)
        closeBtn.contentMode = .scaleAspectFit
        closeBtn.setTitleColor(UIColor(red: 24/255, green: 61/255, blue: 109/255, alpha: 1), for: .normal)
        closeBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        closeBtn.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        modalView.addSubview(closeBtn)
        
        addBtn.setTitle("Add Folder", for: .normal)
        addBtn.titleLabel?.font = UIFont(name: "Avenir-Light", size: 17)
        addBtn.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: .normal)
        addBtn.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5), for: .highlighted)
        addBtn.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        addBtn.backgroundColor = UIColor(red: 24/255, green: 61/255, blue: 109/255, alpha: 1)
        addBtn.layer.cornerRadius = 5
        addBtn.clipsToBounds = true
        addBtn.addTarget(self, action: #selector(addFolder), for: .touchUpInside)
        modalView.addSubview(addBtn)
        
    }
    
    @objc func addFolder() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        guard let folderName = folderNameTxtField.text else { return }
        
        if folderNameTxtField.text!.isEmpty {
            let alert = UIAlertController(title: "Heads Up!", message: "No folder name was entered. Please enter a folder name to continue.", preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
        } else {
            let docRef = fireStoreDb.collection("users").document(userId).collection("Accounts").document(folderName)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    let dataDescription = document.data().map(String.init(describing: )) ?? "nil"
                    print("Document Data: \(dataDescription)")
                } else {
                    // 8.3 - 4:45pm - Working on adding the folder via the 'Add Folder' button
                    self.fireStoreDb.collection("users").document("\(userId)").collection("Accounts").document("\(folderName)").setData([
                        "accountName" : folderName
                    ])
                }
            }
        }
    }
 
    @objc func closeModal() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // Constraint Setups
    func setModalViewConstraints() {
        // Modal
        modalView.translatesAutoresizingMaskIntoConstraints = false
        modalView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        modalView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        modalView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        modalView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    func setmodalTitleConstraints() {
        modalTitle.translatesAutoresizingMaskIntoConstraints = false
        modalTitle.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        modalTitle.widthAnchor.constraint(equalToConstant: 250).isActive = true
        modalTitle.heightAnchor.constraint(equalToConstant: 55).isActive = true
        modalTitle.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 30).isActive = true
    }

    func setFolderNameTextFieldConstraints() {
        folderNameTxtField.translatesAutoresizingMaskIntoConstraints = false
        folderNameTxtField.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        folderNameTxtField.widthAnchor.constraint(equalToConstant: 150).isActive = true
        folderNameTxtField.centerYAnchor.constraint(equalTo: modalView.centerYAnchor, constant: -20).isActive = true
    }
    
    
    func setLineViewConstraints() {
        folderNameLineView.translatesAutoresizingMaskIntoConstraints = false
        folderNameLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        folderNameLineView.topAnchor.constraint(equalTo: folderNameTxtField.bottomAnchor, constant: 1).isActive = true
        folderNameLineView.leftAnchor.constraint(equalTo: folderNameTxtField.leftAnchor).isActive = true
        folderNameLineView.rightAnchor.constraint(equalTo: folderNameTxtField.rightAnchor).isActive = true
    }
    
    func setupWhatsAFolderConstraints() {
        whatsAFolderBtn.translatesAutoresizingMaskIntoConstraints = false
        whatsAFolderBtn.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        whatsAFolderBtn.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -15).isActive = true
    }
    
    func setCloseBtnConstraints() {
        closeBtn.translatesAutoresizingMaskIntoConstraints = false
        closeBtn.leadingAnchor.constraint(equalTo: modalView.leadingAnchor, constant: 20).isActive = true
        closeBtn.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 20).isActive = true
        closeBtn.heightAnchor.constraint(equalToConstant: 13).isActive = true
        closeBtn.widthAnchor.constraint(equalToConstant: 13).isActive = true
    }
    
    func setAddBtnConstraints() {
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        addBtn.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        addBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        addBtn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        addBtn.bottomAnchor.constraint(equalTo: whatsAFolderBtn.topAnchor, constant: -55).isActive = true
    }
    
}
