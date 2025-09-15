//
//  User.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/15/25.
//

import Foundation

struct User {

    let uid: String
    let fullname: String
    let username: String
    let email: String
    let profileImageUrl: String

    init(uid: String, dictionary: [String: Any]) {
        self.uid = uid

        self.fullname = dictionary["fullname"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }

}
