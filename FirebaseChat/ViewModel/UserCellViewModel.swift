//
//  UserCellViewModel.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 10/1/25.
//

import Foundation

struct UserCellViewModel {

    // MARK: - Properties

    private let user: User

    var fullname: String {
        return user.fullname
    }

    var username: String {
        var username = user.username

        if let currentUserId = AuthService.currentUser?.uid,
            currentUserId == user.uid
        {
            username.append(" (You)")
        }

        return username
    }

    // MARK: - Initializers

    init(user: User) {
        self.user = user
    }

}
