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
    var name: String
    var email: String
    var password: String
    var username: String?
    var notes: String?
    var ref: DatabaseReference?
    
    
    init(name: String, email: String, password: String, username: String) {
        self.name = name
        self.password = password
        self.email = email
        self.username = username
        self.notes = nil
        self.ref = nil
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "username": username,
            "email": email,
            "password": password
        ]
    }
}
