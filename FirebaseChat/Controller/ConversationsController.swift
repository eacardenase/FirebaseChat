//
//  ConversationsController.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/5/25.
//

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

}

// MARK: - Actions

extension ConversationsController {

    @objc func profileButtonTapped(_ sender: UIBarButtonItem) {
        print(#function)
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
