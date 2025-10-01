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
    private let footerView = ProfileFooter()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        headerView.delegate = self

        tableView.backgroundColor = .systemGroupedBackground
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.register(
            ProfileCell.self,
            forCellReuseIdentifier: NSStringFromClass(ProfileCell.self)
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
        return ProfileViewModel.allCases.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: NSStringFromClass(ProfileCell.self),
                for: indexPath
            ) as? ProfileCell
        else {
            fatalError("Could not create ProfileCell")
        }

        let viewModel = ProfileViewModel(rawValue: indexPath.row)

        cell.viewModel = viewModel
        cell.accessoryType = .disclosureIndicator

        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        return UIView()
    }

}

// MARK: - Helpers

extension ProfileController {

    private func setupViews() {
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
