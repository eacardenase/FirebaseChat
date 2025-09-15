//
//  AuthService.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/15/25.
//

import FirebaseAuth

struct AuthService {

    private init() {}

    static func logUserIn(
        withEmail email: String,
        password: String,
        completion: @escaping () -> Void
    ) {
        Auth.auth().signIn(withEmail: email, password: password) {
            result,
            error in

            if let error {
                print(
                    "DEBUG: Failed to log in with error: \(error.localizedDescription)"
                )

                return
            }

            completion()
        }
    }

    static func createUser() {

    }

}
