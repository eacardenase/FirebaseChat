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

    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }

    func toDictionary() -> [String: Any] {
        let dictionary: [String: Any] = [
            "uid": uid,
            "fullname": fullname,
            "username": username,
            "email": email,
            "profileImageUrl": profileImageUrl
        ]

        return dictionary
    }

    static func makeSkeletion() -> User {
        return User(dictionary: [:])
    }

}
