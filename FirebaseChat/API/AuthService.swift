//
//  AuthService.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/15/25.
//

import FirebaseAuth
import FirebaseFirestore

//import UIKit

enum AuthError: Error {
    case serverError(String)
}

struct RegistrationCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {

    private init() {}

    static func logUserIn(
        withEmail email: String,
        password: String,
        completion: @escaping (Result<User, AuthError>) -> Void
    ) {
        Auth.auth().signIn(withEmail: email, password: password) {
            result,
            error in

            if let error {
                completion(
                    .failure(
                        .serverError(
                            "Failed to log in with error: \(error.localizedDescription)"
                        )
                    )
                )

                completion(.failure(.serverError(error.localizedDescription)))

                return
            }

            fetchUser(completion: completion)
        }
    }

    static func createUser(
        credentials: RegistrationCredentials,
        completion: @escaping (Result<User, AuthError>) -> Void
    ) {
        Auth.auth().createUser(
            withEmail: credentials.email,
            password: credentials.password
        ) {
            result,
            error in

            if let error {
                completion(
                    .failure(.serverError(error.localizedDescription))
                )

                return
            }

            guard let uid = result?.user.uid else {
                completion(
                    .failure(.serverError("Failed to get user id."))
                )

                return
            }

            StorageService.uploadProfileUser(
                forUserId: uid,
                image: credentials.profileImage
            ) { result in
                switch result {
                case .success(let profileImageUrl):
                    let userData = [
                        "fullname": credentials.fullname,
                        "username": credentials.username,
                        "email": credentials.email,
                        "profileImageUrl": profileImageUrl,
                    ]

                    AuthService.storeDataForUser(
                        withId: uid,
                        data: userData,
                        completion: completion
                    )
                case .failure(let error):
                    completion(
                        .failure(.serverError(error.localizedDescription))
                    )
                }
            }

        }
    }

    static func fetchUser(
        completion: @escaping (Result<User, AuthError>) -> Void
    ) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(
                .failure(
                    .serverError("Failed to get user id, current user is nil.")
                )
            )

            return
        }

        Firestore.firestore().collection("users").document(uid).getDocument {
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

            let user = User(uid: uid, dictionary: userData)

            completion(.success(user))
        }
    }

    static func storeDataForUser(
        withId uid: String,
        data: [String: String],
        completion: @escaping (Result<User, AuthError>) -> Void
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
