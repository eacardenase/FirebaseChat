//
//  ProfileController.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/30/25.
//

import UIKit

class ProfileController: UITableViewController {

    // MARK: - Properties

    private let headerView = ProfileHeader()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.contentInsetAdjustmentBehavior = .never
        tableView.tableHeaderView = headerView
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self)
        )

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

}
