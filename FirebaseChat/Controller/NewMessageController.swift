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
    var filteredUsers = [User]()

    var isLoaded = false

    private var inSearchMode: Bool {
        guard let text = searchController.searchBar.text,
            !text.isEmpty
        else {
            return false
        }

        return searchController.isActive
    }

    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)

        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Search for a user"
        controller.searchResultsUpdater = self
        controller.searchBar.searchTextField.tintColor = .systemPurple
        controller.searchBar.searchTextField.addTarget(
            self,
            action: #selector(showCancelButton),
            for: .touchUpInside
        )

        return controller
    }()

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
        tableView.register(
            NothingFoundCell.self,
            forCellReuseIdentifier: NSStringFromClass(NothingFoundCell.self)
        )
    }

}

// MARK: - Helpers

extension NewMessageController {

    private func setupNavBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        definesPresentationContext = true

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

    @objc func showCancelButton(_ sender: UISearchTextField) {
        searchController.searchBar.showsCancelButton = true
    }

}

// MARK: - UITableViewDataSource

extension NewMessageController {

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        if inSearchMode {
            return filteredUsers.isEmpty ? 1 : filteredUsers.count
        }

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

        if inSearchMode && filteredUsers.isEmpty {
            return tableView.dequeueReusableCell(
                withIdentifier: NSStringFromClass(NothingFoundCell.self),
                for: indexPath
            )
        }

        cell.user =
            inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]

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
        let user =
            inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]

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

// MARK: - UISearchResultsUpdating

extension NewMessageController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard
            let searchText = searchController.searchBar.text?.lowercased()
        else { return }

        filteredUsers = users.filter { user in
            return user.username.lowercased().contains(searchText)
                || user.fullname.lowercased().contains(searchText)
        }

        self.tableView.reloadData()
    }

}
