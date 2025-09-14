//
//  ConversationsController.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/5/25.
//

import FirebaseAuth
import UIKit

class ConversationsController: UIViewController {

    // MARK: - Properties

    private lazy var tableView: UITableView = {
        let _tableView = UITableView()

        _tableView.backgroundColor = .white
        _tableView.rowHeight = 80
        _tableView.dataSource = self
        _tableView.delegate = self
        _tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self)
        )

        return _tableView
    }()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupViews()
        authenticateUser()
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

        tableView.frame = view.frame

        view.addSubview(tableView)
    }

    private func presentLoginScreen() {
        OperationQueue.main.addOperation {
            let loginController = LoginController()
            let navController = UINavigationController(
                rootViewController: loginController
            )

            navController.modalPresentationStyle = .fullScreen

            self.present(navController, animated: true)
        }
    }

    private func logout() {
        do {
            try Auth.auth().signOut()

            presentLoginScreen()
        } catch {
            print("DEBUG: Error signing out. \(error.localizedDescription)")
        }
    }

}

// MARK: - Actions

extension ConversationsController {

    @objc func profileButtonTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )

        let logoutAction = UIAlertAction(title: "Log out", style: .destructive)
        { _ in self.logout() }

        alertController.addAction(logoutAction)
        alertController.addAction(
            UIAlertAction(title: "Cancel", style: .cancel)
        )

        present(alertController, animated: true)
    }

}

// MARK: - UITableViewDataSource

extension ConversationsController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: UITableViewCell.self),
            for: indexPath
        )

        cell.selectionStyle = .none

        return cell
    }

}

// MARK: - UITableViewDelegate

extension ConversationsController: UITableViewDelegate {

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        print(indexPath.row)
    }

}

// MARK: - API

extension ConversationsController {

    func authenticateUser() {
        if let currentUser = Auth.auth().currentUser {
            print("DEBUG: User id is \(currentUser.uid)")
        } else {
            presentLoginScreen()
        }
    }

}
