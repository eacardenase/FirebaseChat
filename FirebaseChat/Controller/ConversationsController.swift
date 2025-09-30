//
//  ConversationsController.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/5/25.
//

import UIKit

class ConversationsController: UIViewController {

    // MARK: - Properties

    private var recentMessages = [Message]()

    private lazy var tableView: UITableView = {
        let _tableView = UITableView()

        _tableView.backgroundColor = .white
        _tableView.dataSource = self
        _tableView.delegate = self
        _tableView.register(
            ConversationCell.self,
            forCellReuseIdentifier: NSStringFromClass(ConversationCell.self)
        )

        return _tableView
    }()

    private lazy var newMessageButton: UIButton = {
        let button = UIButton(type: .system)
        let imageConf = UIImage.SymbolConfiguration(
            textStyle: .title3,
            scale: .large,
        )

        let image = UIImage(systemName: "plus", withConfiguration: imageConf)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.backgroundColor = .systemPurple
        button.tintColor = .white
        button.addTarget(
            self,
            action: #selector(newMessageButtonTapped),
            for: .touchUpInside
        )

        return button
    }()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
        setupViews()
        authenticateUser()
        fetchConversations()
    }

    override func viewDidLayoutSubviews() {
        newMessageButton.layer.cornerRadius = newMessageButton.frame.height / 2
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
        view.addSubview(newMessageButton)

        // newMessageButton
        NSLayoutConstraint.activate([
            newMessageButton.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -24
            ),
            newMessageButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -16
            ),
            newMessageButton.heightAnchor.constraint(equalToConstant: 56),
            newMessageButton.widthAnchor.constraint(
                equalTo: newMessageButton.heightAnchor
            ),
        ])
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
        showLoader()

        recentMessages = []

        AuthService.logUserOut { error in
            self.showLoader(false)

            if let error {
                print("DEBUG: Error signing out. \(error.localizedDescription)")

                return
            }

            self.presentLoginScreen()
        }
    }

    private func showChatController(for user: User) {
        let controller = ChatController(user: user)

        navigationController?.pushViewController(controller, animated: true)
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

    @objc func newMessageButtonTapped(_ sender: UIButton) {
        let controller = NewMessageController()
        controller.delegate = self

        let navController = UINavigationController(
            rootViewController: controller
        )

        navController.setupAppearance()
        navController.modalPresentationStyle = .fullScreen

        present(navController, animated: true)
    }

}

// MARK: - UITableViewDataSource

extension ConversationsController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return recentMessages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: NSStringFromClass(ConversationCell.self),
                for: indexPath
            ) as? ConversationCell
        else {
            fatalError("Could not create ConversationCell cell")
        }

        cell.conversation = recentMessages[indexPath.row]
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
        guard let user = recentMessages[indexPath.row].user else { return }

        showChatController(for: user)
    }

}

// MARK: - API

extension ConversationsController {

    func authenticateUser() {
        AuthService.verifyLogin { error in
            if case .serverError(let message) = error {
                print("DEBUG: Unable to verify login with error: \(message)")

                self.presentLoginScreen()
            }
        }
    }

    func fetchConversations() {
        ChatService.fetchRecentMessages { result in
            switch result {
            case .success(let recentMessages):
                self.recentMessages = Array(recentMessages.values)

                self.tableView.reloadData()
            case .failure(let error):
                print(
                    "DEBUG: Failed to fetch conversations with error: \(error.localizedDescription)"
                )
            }
        }
    }

}

// MARK: - NewMessageControllerDelegate

extension ConversationsController: NewMessageControllerDelegate {

    func controller(
        _ controller: NewMessageController,
        wantsToChatWith user: User
    ) {
        controller.dismiss(animated: true) {
            self.showChatController(for: user)
        }
    }

}
