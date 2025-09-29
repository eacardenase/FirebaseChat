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
            "timestamp": Timestamp(),
            "user": user.toDictionary(),
        ]

        Constants.FirebaseFirestore.MessagesCollection.document(currentUserUid)
            .collection(user.uid).addDocument(
                data: data
            ) { error in
                if let error {
                    completion(error)

                    return
                }

                if currentUserUid != user.uid {
                    Constants.FirebaseFirestore.MessagesCollection.document(
                        user.uid
                    ).collection(currentUserUid).addDocument(
                        data: data,
                        completion: completion
                    )
                }

                Constants.FirebaseFirestore.MessagesCollection.document(
                    currentUserUid
                ).collection("recent_messages").document(user.uid).setData(data)

                Constants.FirebaseFirestore.MessagesCollection.document(
                    user.uid
                ).collection("recent_messages").document(currentUserUid)
                    .setData(data)
            }
    }

    static func fetchMessages(
        for user: User,
        completion: @escaping ([Message]) -> Void
    ) {
        var messages = [Message]()

        guard let currentUserId = AuthService.currentUser?.uid else { return }

        let query = Constants.FirebaseFirestore.MessagesCollection.document(
            currentUserId
        ).collection(user.uid).order(by: "timestamp")

        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach { change in
                if change.type == .added {
                    let dictionary = change.document.data()
                    let newMessage = Message(dictionary: dictionary)

                    messages.append(newMessage)
                }
            }

            completion(messages)
        }
    }

    static func fetchRecentMessages(
        completion: @escaping (Result<[Message], NetworkingError>) -> Void
    ) {
        var recentMessages = [Message]()

        guard let currentUserId = AuthService.currentUser?.uid else {
            return
        }

        let query = Constants.FirebaseFirestore.MessagesCollection.document(
            currentUserId
        ).collection("recent_messages").order(by: "timestamp")

        query.addSnapshotListener { snapshot, error in
            if let error {
                completion(.failure(.serverError(error.localizedDescription)))

                return
            }

            guard let snapshot else {
                completion(
                    .failure(.serverError("Error getting conversations."))
                )

                return
            }

            snapshot.documentChanges.forEach { change in
                let dictionary = change.document.data()
                let message = Message(dictionary: dictionary)

                recentMessages.append(message)
            }

            completion(.success(recentMessages))
        }
    }

}
