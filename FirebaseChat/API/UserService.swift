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
        Constants.FirebaseFirestore.UsersCollection.document(userId).getDocument
        {
            (snapshot, error) in

            if let error {
                completion(
                    .failure(.serverError(error.localizedDescription))
                )

                return
            }

            guard let snapshot, snapshot.exists else {
                completion(
                    .failure(.serverError("Failed to get user data."))
                )

                return
            }

            do {
                let user = try snapshot.data(as: User.self)

                completion(.success(user))
            } catch {
                completion(.failure(.decodingError))
            }
        }
    }

    static func fetchUsers(
        completion: @escaping (Result<[User], NetworkingError>) -> Void
    ) {
        Constants.FirebaseFirestore.UsersCollection.getDocuments {
            (snapshot, error) in

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

            let users = snapshot.documents.compactMap { document in
                return try? document.data(as: User.self)
            }

            completion(.success(users))
        }
    }

    static func store(
        _ user: User,
        completion: @escaping (Result<User, NetworkingError>) -> Void
    ) {
        do {
            try Constants.FirebaseFirestore.UsersCollection.document(user.uid)
                .setData(from: user)

            completion(.success(user))
        } catch {
            completion(
                .failure(.serverError(error.localizedDescription))
            )
        }
    }

}
