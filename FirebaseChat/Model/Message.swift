//
//  Message.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/25/25.
//

import FirebaseAuth
import FirebaseCore

struct Message {

    let text: String
    let timestamp: Timestamp
    let isFromCurrentUser: Bool
    let user: User

    init(dictionary: [String: Any]) {
        let userData = dictionary["user"] as? [String: Any] ?? [:]

        self.user = User(dictionary: userData)
        self.text = dictionary["text"] as? String ?? ""
        self.timestamp =
            dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())

        self.isFromCurrentUser = user.uid != AuthService.currentUser?.uid
    }

}
