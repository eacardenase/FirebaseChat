//
//  ConversationsController.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/5/25.
//

import UIKit

class ConversationsController: UIViewController {

    // MARK: - Properties

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupViews()
    }

}

// MARK: - Helpers

extension ConversationsController {

    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Messages"

        let profileImage = UIImage(systemName: "person.circle.fill")

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: profileImage,
            style: .plain,
            target: self,
            action: #selector(profileButtonTapped)
        )
    }

    private func setupViews() {
        view.backgroundColor = .white
    }

}

// MARK: - Actions

extension ConversationsController {

    @objc func profileButtonTapped(_ sender: UIBarButtonItem) {
        print(#function)
    }

}
