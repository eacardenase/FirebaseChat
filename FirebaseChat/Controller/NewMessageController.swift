//
//  NewMessageController.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/16/25.
//

import UIKit

class NewMessageController: UITableViewController {

    // MARK: - Properties

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchUsers()
        setupNavBar()
        setupViews()

        tableView.register(
            UserCell.self,
            forCellReuseIdentifier: NSStringFromClass(UserCell.self)
        )
    }

}

// MARK: - Helpers

extension NewMessageController {

    private func setupNavBar() {
        navigationItem.title = "New Message"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(dismissController)
        )
    }

    private func setupViews() {
        view.backgroundColor = .white
    }

}

// MARK: - Actions

extension NewMessageController {

    @objc func dismissController(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

}

// MARK: - UITableViewDataSource

extension NewMessageController {

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 2
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: NSStringFromClass(UserCell.self),
                for: indexPath
            ) as? UserCell
        else {
            fatalError("Could not instantiate UserCell")
        }

        return cell
    }

}

// MARK: - API

extension NewMessageController {

    private func fetchUsers() {
        UserService.fetchUsers { result in
            if case .success(let users) = result {
                print(users)
            }
        }
    }

}
