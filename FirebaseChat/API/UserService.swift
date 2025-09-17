//
//  UserService.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/17/25.
//

import FirebaseFirestore
import Foundation

struct UserService {

    private init() {}

    static func fetchUser(
        withId userId: String,
        completion: @escaping (Result<User, NetworkingError>) -> Void
    ) {
        Firestore.firestore().collection("users").document(userId).getDocument {
            snapshot,
            error in

            if let error {
                completion(
                    .failure(.serverError(error.localizedDescription))
                )

                return
            }

            guard let snapshot, snapshot.exists,
                let userData = snapshot.data()
            else {
                completion(
                    .failure(.serverError("Failed to get user data."))
                )

                return
            }

            let user = User(uid: userId, dictionary: userData)

            completion(.success(user))
        }
    }

    static func fetchUsers(
        completion: @escaping (Result<[User], NetworkingError>) -> Void
    ) {
        Firestore.firestore().collection("users").getDocuments {
            snapshot,
            error in
            if let error {
                completion(
                    .failure(.serverError(error.localizedDescription))
                )

                return
            }

            guard let snapshot else {
                completion(
                    .failure(.serverError("Failed to get users data."))
                )

                return
            }

            let users = snapshot.documents.map { document in
                return User(
                    uid: document.documentID,
                    dictionary: document.data()
                )
            }

            completion(.success(users))
        }
    }

    static func storeUser(
        withId uid: String,
        data: [String: String],
        completion: @escaping (Result<User, NetworkingError>) -> Void
    ) {
        let user = User(uid: uid, dictionary: data)

        Firestore.firestore().collection("users").document(uid)
            .setData(
                data
            ) { error in
                if let error {
                    completion(
                        .failure(
                            .serverError(error.localizedDescription)
                        )
                    )

                    return
                }

                completion(.success(user))
            }
    }

}
