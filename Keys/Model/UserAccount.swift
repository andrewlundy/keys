//
//  User.swift
//  Keys
//
//  Created by Andrew Lundy on 3/9/19.
//  Copyright © 2019 Andrew Lundy. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct UserAccount {
    let name: String
    let email: String
    let password: String

    
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.password = password
        self.email = email
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "email": email,
            "password": password
        ]
    }
}
