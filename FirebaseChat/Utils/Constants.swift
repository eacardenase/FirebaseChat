//
//  Constants.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/26/25.
//

import FirebaseFirestore

struct Constants {

    private init() {}

    struct FirebaseFirestore {

        private init() {}

        static let UsersCollection = Firestore.firestore().collection("users")

        static let MessagesCollection = Firestore.firestore().collection(
            "messages"
        )

    }

}
