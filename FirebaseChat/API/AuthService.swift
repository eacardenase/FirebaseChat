//
//  AuthService.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/15/25.
//

import FirebaseAuth
import UIKit

enum NetworkingError: Error {
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
        completion: @escaping (Error?) -> Void
    ) {
        Auth.auth().signIn(withEmail: email, password: password) {
            result,
            error in

            if let error {
                completion(error)

                return
            }

            completion(nil)

        }
    }

    static func logUserOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()

            completion(nil)
        } catch {
            completion(error)
        }
    }

    static func createUser(
        credentials: RegistrationCredentials,
        completion: @escaping (Result<User, NetworkingError>) -> Void
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

                    UserService.storeUser(
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

    static var currentUser: FirebaseAuth.User? {
        return Auth.auth().currentUser
    }

    static func verifyLogin(
        completion: @escaping (NetworkingError?) -> Void
    ) {
        guard Auth.auth().currentUser != nil else {
            completion(
                .serverError("Failed to get user, current user is nil.")
            )

            return
        }

        completion(nil)
    }

}
