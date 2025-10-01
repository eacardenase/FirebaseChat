//
//  ProfileViewModel.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 10/1/25.
//

import Foundation

enum ProfileViewModel: Int, CaseIterable {
    case accountInfo
    case settings
    case savedMessages

    var description: String {
        switch self {
        case .accountInfo: return "Account Info"
        case .settings: return "Settings"
        case .savedMessages: return "Saved Messages"
        }
    }

    var iconImage: String {
        switch self {
        case .accountInfo: return "person.circle"
        case .settings: return "gear"
        case .savedMessages: return "envelope.circle"
        }
    }

}
