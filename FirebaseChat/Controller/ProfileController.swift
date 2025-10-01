//
//  ProfileController.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/30/25.
//

import UIKit

class ProfileController: UITableViewController {

    // MARK: - Properties

    private var user: User? {
        didSet {
            headerView.user = user
        }
    }

    private let headerView = ProfileHeader()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.delegate = self

        tableView.contentInsetAdjustmentBehavior = .never
        tableView.tableHeaderView = headerView
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self)
        )

        fetchUser()
        setupViews()
    }

}

// MARK: - UITableViewDataSource

extension ProfileController {

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
        let cell = tableView.dequeueReusableCell(
            withIdentifier: NSStringFromClass(UITableViewCell.self),
            for: indexPath
        )

        return cell
    }

}

// MARK: - Helpers

extension ProfileController {

    private func setupViews() {
        tableView.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
    }

}

// MARK: - Actions

extension ProfileController {

}

// MARK: - API

extension ProfileController {

    func fetchUser() {
        guard let currentUserId = AuthService.currentUser?.uid else { return }

        UserService.fetchUser(withId: currentUserId) { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let error):
                print(
                    "DEBUG: Failed to fetch user with error: \(error.localizedDescription)"
                )
            }
        }
    }

}

// MARK: - ProfileHeaderDelegate

extension ProfileController: ProfileHeaderDelegate {

    func dismissController() {
        dismiss(animated: true)
    }

}
