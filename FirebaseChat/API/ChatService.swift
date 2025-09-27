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
        guard let currentUserUid = AuthService.currentUser?.uid else { return }

        let data: [String: Any] = [
            "text": message,
            "fromId": currentUserUid,
            "toId": user.uid,
            "timestamp": Timestamp(),
        ]

        Constants.FirebaseFirestore.MessagesCollection.document(currentUserUid)
            .collection(user.uid).addDocument(
                data: data
            ) { error in
                if let error {
                    completion(error)

                    return
                }

                Constants.FirebaseFirestore.MessagesCollection.document(
                    user.uid
                ).collection(currentUserUid).addDocument(
                    data: data
                ) { error in
                    if let error {
                        completion(error)

                        return
                    }

                    completion(nil)
                }
            }
    }

}
