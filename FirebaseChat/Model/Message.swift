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
    let toId: String
    let fromId: String
    let timestamp: Timestamp
    var user: User?

    let isFromCurrentUser: Bool

    init(dictionary: [String: AnyObject]) {
        self.text = dictionary["text"] as? String ?? ""
        self.toId = dictionary["toId"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.timestamp =
            dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())

        self.isFromCurrentUser = fromId == AuthService.currentUserId
    }

}
