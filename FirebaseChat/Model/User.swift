//
//  User.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/15/25.
//

import Foundation

struct User: Codable {

    let uid: String
    let fullname: String
    let username: String
    let email: String
    let profileImageUrl: String

    static func makeSkeletion() -> User {
        return User(
            uid: "",
            fullname: "",
            username: "",
            email: "",
            profileImageUrl: ""
        )
    }

}
