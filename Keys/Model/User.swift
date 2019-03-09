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

struct User {
    let name: String
    let password: String
 
    init(name: String, password: String) {
        self.name = name
        self.password = password
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "password": password
        ]
    }
}
