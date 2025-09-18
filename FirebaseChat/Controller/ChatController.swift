//
//  ChatController.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/17/25.
//

import UIKit

class ChatController: UICollectionViewController {

    // MARK: - Properties

    private let user: User

    // MARK: - Initializers

    init(user: User) {
        self.user = user

        super.init(collectionViewLayout: UICollectionViewLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.prefersLargeTitles = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

// MARK: - Helpers

extension ChatController {

    private func setupViews() {
        collectionView.backgroundColor = .white

        navigationItem.title = user.username
    }

}
