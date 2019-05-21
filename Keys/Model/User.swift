//
//  User.swift
//  Keys
//
//  Created by Andrew Lundy on 5/18/19.
//  Copyright © 2019 Andrew Lundy. All rights reserved.
//

import Foundation
struct User {
    var name: String?
    var email: String?
    var password: String?
    var notes: String?
    
    init?(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
        self.password = dictionary["password"] as? String
        self.notes = dictionary[""] as? String
    }
}
