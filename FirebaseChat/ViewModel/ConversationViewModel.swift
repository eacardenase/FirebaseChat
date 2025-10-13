//
//  ConversationViewModel.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/29/25.
//

import Foundation

struct ConversationViewModel {

    // MARK: - Properties

    private let conversation: Conversation

    var username: String? {
        var username = conversation.user.username

        if let currentUser = AuthService.currentUser,
            currentUser.uid == conversation.user.uid
        {
            username.append(" (You)")
        }

        return username
    }

    var text: String {
        return conversation.message.text
    }

    var profileImageUrl: URL? {
        return URL(string: conversation.user.profileImageUrl)
    }

    var timestamp: String {
        let date = conversation.message.timestamp.dateValue()
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "hh:mm a"

        return dateFormatter.string(from: date)
    }

    // MARK: - Initializers

    init(conversation: Conversation) {
        self.conversation = conversation
    }

}
