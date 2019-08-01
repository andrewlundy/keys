//
//  AddFoldersModal.swift
//  
//
//  Created by Andrew Lundy on 7/19/19.
//

import UIKit

class AddFoldersModal: UIViewController {

    let screenSize: CGRect = UIScreen.main.bounds
    
    // UI Elements
    let modalView = UIView()
    let modalTitle = UILabel()
    
    let folderNameTxtField = UITextField()
    let folderNameLineView = UIView()
    
    let addButton = UIButton()
    
    let whatsAFolderBtn = UIButton()
    let alert = UIAlertController(title: "What's a Folder?", message: "A folder is the main account type in which all your sub accounts will be stored.", preferredStyle: .alert)
    
    @objc func presentAlert() {
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            print("The action was successful.")
        }))
    }
    

    func addSubView() {
        setupModalView()
        setModalViewConstraints()
        setmodalTitleConstraints()
        setFolderNameTextFieldConstraints()
        setLineViewConstraints()
        setupWhatsAFolderConstraints()
    }
    
    // UI Element Setups
    func setupModalView() {
        modalView.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
        modalView.layer.cornerRadius = 25
        modalView.layer.masksToBounds = true
        view.addSubview(modalView)
        
        modalTitle.text = "Add a New Folder"
        modalTitle.font = UIFont(name: "Avenir-Heavy", size: 19)
        modalTitle.textAlignment = .center
        modalView.addSubview(modalTitle)
        
        folderNameTxtField.font = UIFont(name: "Avenir-Book", size: 16)
        folderNameTxtField.placeholder = "Folder Name"
        modalView.addSubview(folderNameTxtField)
        
        folderNameLineView.backgroundColor = UIColor(red: 13/255, green: 62/255, blue: 108/255, alpha: 1)
        modalView.addSubview(folderNameLineView)
        
        whatsAFolderBtn.setTitle("What's a Folder?", for: .normal)
        whatsAFolderBtn.setTitleColor(UIColor(red: 24/255, green: 61/255, blue: 109/255, alpha: 1), for: .normal)
        whatsAFolderBtn.titleLabel?.font = UIFont(name: "Avenir-Light", size: 14)
        whatsAFolderBtn.frame = CGRect(x: 15, y: 50, width: 300, height: 30)
        whatsAFolderBtn.addTarget(self, action: #selector(presentAlert), for: .touchUpInside)
        modalView.addSubview(whatsAFolderBtn)
    }
 
    
    // Constraint Setups
    func setModalViewConstraints() {
        // Modal
        modalView.translatesAutoresizingMaskIntoConstraints = false
        modalView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        modalView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        modalView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        modalView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    func setmodalTitleConstraints() {
        modalTitle.translatesAutoresizingMaskIntoConstraints = false
        modalTitle.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        modalTitle.widthAnchor.constraint(equalToConstant: 250).isActive = true
        modalTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        modalTitle.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 25).isActive = true
    }

    func setFolderNameTextFieldConstraints() {
        folderNameTxtField.translatesAutoresizingMaskIntoConstraints = false
        folderNameTxtField.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        folderNameTxtField.widthAnchor.constraint(equalToConstant: 150).isActive = true
        folderNameTxtField.centerYAnchor.constraint(equalTo: modalView.centerYAnchor).isActive = true
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
        whatsAFolderBtn.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -25).isActive = true
    
    }
    
}
