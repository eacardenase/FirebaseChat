//
//  ProfileViewModel.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 10/1/25.
//

import Foundation

struct ProfileHeaderViewModel {

    // MARK: - Properties

    private let profile: User

    var fullname: String {
        return profile.fullname
    }

    var username: String {
        return "@\(profile.username)"
    }

    var profileImageUrl: URL? {
        return URL(string: profile.profileImageUrl)
    }

    // MARK: - Initializers

    init(profile: User) {
        self.profile = profile
    }

}
