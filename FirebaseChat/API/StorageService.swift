//
//  StorageService.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/15/25.
//

import FirebaseStorage
import UIKit

enum StorageError: Error {
    case serverError(String)
}

struct StorageService {

    private init() {}

    static func uploadProfileUser(
        forUserId userId: String,
        image: UIImage,
        completion: @escaping (Result<String, StorageError>) -> Void
    ) {
        guard let imageData = image.jpegData(compressionQuality: 0.3) else {
            completion(
                .failure(.serverError("Image data could not be compressed."))
            )

            return
        }

        let ref = Storage.storage().reference(
            withPath: "/profile_images/\(userId)"
        )

        ref.putData(imageData, metadata: nil) { matadata, error in
            if let error {
                completion(
                    .failure(
                        .serverError(
                            "Failed to upload image with error \(error.localizedDescription)"
                        )
                    )

                )

                return
            }

            ref.downloadURL { url, error in
                if let error {
                    completion(
                        .failure(
                            .serverError(
                                "Failed to get image download url with error: \(error.localizedDescription)"
                            )
                        )
                    )

                    return
                }

                guard let profileImageUrl = url?.absoluteString else {
                    completion(
                        .failure(
                            .serverError("Failed to get profile image url.")
                        )
                    )

                    return
                }

                completion(.success(profileImageUrl))
            }
        }
    }

}
