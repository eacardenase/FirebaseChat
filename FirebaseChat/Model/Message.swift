//
//  Message.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/25/25.
//

import FirebaseCore
import Foundation

struct Message: Codable {

    let text: String
    let toId: String
    let fromId: String
    let timestamp: Timestamp

}
