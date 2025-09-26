//
//  ChatService.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/26/25.
//

import FirebaseCore
import FirebaseFirestore

struct ChatService {

    static func uploadMessage(
        _ message: String,
        to user: User,
        completion: @escaping (Error?) -> Void
    ) {
        guard let currentUid = AuthService.currentUserId else { return }

        let data: [String: Any] = [
            "text": message,
            "fromId": currentUid,
            "toId": user.uid,
            "timestamp": Timestamp(),
        ]

        Constants.FirebaseFirestore.MessagesCollection.document(currentUid)
            .collection(user.uid).addDocument(
                data: data
            ) { error in
                if let error {
                    print("DEBUG: \(error.localizedDescription)")

                    completion(error)

                    return
                }

                Constants.FirebaseFirestore.MessagesCollection.document(
                    user.uid
                ).collection(currentUid).addDocument(
                    data: data
                ) { error in
                    if let error {
                        print("DEBUG: \(error.localizedDescription)")

                        completion(error)

                        return
                    }

                    completion(nil)
                }
            }
    }

}
