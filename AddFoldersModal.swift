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
    let lineView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
    }
    

    func addSubView() {
        setupModalView()
        setModalViewConstraints()
        setmodalTitleConstraints()
        setFolderNameTextFieldConstraints()
        setLineViewConstraints()
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
        folderNameTxtField.placeholder = "Test"
        modalView.addSubview(folderNameTxtField)
        
        lineView.backgroundColor = UIColor(red: 13/255, green: 62/255, blue: 108/255, alpha: 1)
        modalView.addSubview(lineView)
    }
 
    
    // Constraint Setups
    func setModalViewConstraints() {
        // Modal
        modalView.translatesAutoresizingMaskIntoConstraints = false
        modalView.heightAnchor.constraint(equalToConstant: 375).isActive = true
        modalView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        modalView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        modalView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    func setmodalTitleConstraints() {
        modalTitle.translatesAutoresizingMaskIntoConstraints = false
        modalTitle.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        modalTitle.widthAnchor.constraint(equalToConstant: 250).isActive = true
        modalTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        modalTitle.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 30).isActive = true
    }

    func setFolderNameTextFieldConstraints() {
        folderNameTxtField.translatesAutoresizingMaskIntoConstraints = false
        folderNameTxtField.centerXAnchor.constraint(equalTo: modalView.centerXAnchor).isActive = true
        folderNameTxtField.widthAnchor.constraint(equalToConstant: 150).isActive = true
        folderNameTxtField.topAnchor.constraint(equalTo: modalTitle.bottomAnchor, constant: 50).isActive = true
    }
    
    
    func setLineViewConstraints() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        lineView.topAnchor.constraint(equalTo: folderNameTxtField.bottomAnchor, constant: 1).isActive = true
        lineView.leftAnchor.constraint(equalTo: folderNameTxtField.leftAnchor).isActive = true
        lineView.rightAnchor.constraint(equalTo: folderNameTxtField.rightAnchor).isActive = true
    }
    
}
