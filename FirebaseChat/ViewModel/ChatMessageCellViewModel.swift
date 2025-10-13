//
//  ChatMessageCellViewModel.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/25/25.
//

import UIKit

struct ChatMessageCellViewModel {

    private let message: Message

    var messageBackgroundColor: UIColor {
        return message.isFromCurrentUser ? .lightGray : .systemPurple
    }

    var messageTextColor: UIColor {
        return message.isFromCurrentUser ? .black : .white
    }

    var timestamp: String {
        let date = message.timestamp.dateValue()
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "hh:mm a"

        return dateFormatter.string(from: date)
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

    var profileImageUrl: URL? {
        //        guard let user = message.user else { return nil }
        //
        //        return URL(string: user.profileImageUrl)

        return nil
    }

    init(message: Message) {
        self.message = message
    }

}
