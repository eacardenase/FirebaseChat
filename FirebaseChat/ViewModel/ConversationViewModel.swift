//
//  ConversationViewModel.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/29/25.
//

import Foundation

struct ConversationViewModel {

    // MARK: - Properties

    private let conversation: Message

    var username: String? {
        guard let user = conversation.user else { return nil }

        var username = user.username

        if let currentUser = AuthService.currentUser,
            currentUser.uid == user.uid
        {
            username.append(" (You)")
        }

        return username
    }

    var text: String {
        return conversation.text
    }

    var profileImageUrl: URL? {
        guard let user = conversation.user else { return nil }

        return URL(string: user.profileImageUrl)
    }

    var timestamp: String {
        let date = conversation.timestamp.dateValue()
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "hh:mm a"

        return dateFormatter.string(from: date)
    }

    // MARK: - Initializers

    init(conversation: Message) {
        self.conversation = conversation
    }

}
