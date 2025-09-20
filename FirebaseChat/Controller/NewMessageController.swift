//
//  NewMessageController.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/16/25.
//

import UIKit

protocol NewMessageControllerDelegate: AnyObject {

    func controller(
        _ controller: NewMessageController,
        wantsToChatWith user: User
    )

}

class NewMessageController: UITableViewController {

    // MARK: - Properties

    weak var delegate: NewMessageControllerDelegate?

    var users = [User]()

    var isLoaded = false

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSkeletons()
        setupNavBar()
        setupViews()
        fetchUsers()

        tableView.register(
            UserCell.self,
            forCellReuseIdentifier: NSStringFromClass(UserCell.self)
        )
        tableView.register(
            UserSkeletonCell.self,
            forCellReuseIdentifier: NSStringFromClass(UserSkeletonCell.self)
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

    private func setupSkeletons() {
        let skeletonAccount = User.makeSkeletion()

        users = Array(repeating: skeletonAccount, count: 5)

        configureTableCells(with: users)
    }

    private func configureTableCells(with users: [User]) {

    }

    private func reloadViews() {
        isLoaded = true

        configureTableCells(with: users)
        tableView.reloadData()
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
        return users.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if !isLoaded {
            let skeletonCell = tableView.dequeueReusableCell(
                withIdentifier: NSStringFromClass(UserSkeletonCell.self),
                for: indexPath
            )

            return skeletonCell
        }

        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: NSStringFromClass(UserCell.self),
                for: indexPath
            ) as? UserCell
        else {
            fatalError("Could not instantiate UserCell")
        }

        cell.user = users[indexPath.row]
        cell.selectionStyle = .none

        return cell
    }

}

// MARK: - UITableViewDelegate

extension NewMessageController {

    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let user = users[indexPath.row]

        delegate?.controller(self, wantsToChatWith: user)
    }

}

// MARK: - API

extension NewMessageController {

    private func fetchUsers() {
        UserService.fetchUsers { result in
            if case .success(let users) = result {
                self.users = users

                self.reloadViews()
            }
        }
    }

}
