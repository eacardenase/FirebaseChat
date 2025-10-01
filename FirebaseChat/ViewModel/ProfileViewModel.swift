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

    var description: String {
        switch self {
        case .accountInfo: return "Account Info"
        case .settings: return "Settings"
        }
    }

    var iconImage: String {
        switch self {
        case .accountInfo: return "person.circle"
        case .settings: return "gear"
        }
    }

}
