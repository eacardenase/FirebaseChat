//
//  MessageViewModel.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/25/25.
//

import UIKit

struct MessageViewModel {

    private let message: Message

    var messageBackgroundColor: UIColor {
        return message.isFromCurrentUser ? .lightGray : .systemPurple
    }

    var messageTextColor: UIColor {
        return message.isFromCurrentUser ? .black : .white
    }

    var trailingAnchorActive: Bool {
        return message.isFromCurrentUser
    }

    var leadingAnchorActive: Bool {
        return !message.isFromCurrentUser
    }

    var shouldHideProfileImage: Bool {
        return message.isFromCurrentUser
    }

    init(message: Message) {
        self.message = message
    }

}
