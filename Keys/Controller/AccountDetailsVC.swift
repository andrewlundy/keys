//
//  AccountDetailsVC.swift
//  Keys
//
//  Created by Andrew Lundy on 3/28/19.
//  Copyright © 2019 Andrew Lundy. All rights reserved.
//

import UIKit

class AccountDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    
    var account: UserAccount!
    
    var emailAddress: String!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(account)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
   

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ACCOUNT_DETAIL_CELL_ID) as! AccountDetailsCell
        cell.detailLbl.text = "Email"
        cell.detailValue.text = account.name
        return cell
    }

  

}
