//
//  AddFoldersModal.swift
//  
//
//  Created by Andrew Lundy on 7/19/19.
//

import UIKit

class AddFoldersModal: UIViewController {

    let screenSize: CGRect = UIScreen.main.bounds
    let modalView = UIView()
    let modalTitle = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
    }
    

    func addSubView() {
        modalView.backgroundColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1.0)
        modalView.layer.cornerRadius = 25
        modalTitle.text = "Add a New Folder"
        modalTitle.font = UIFont(name: "Avenir-Heavy", size: 19)
        modalTitle.textAlignment = .center
        view.addSubview(modalView)
        modalView.addSubview(modalTitle)
        setModalViewConstraints()
        setmodalTitleConstraints()
    }
    
    func setModalViewConstraints() {
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

}
