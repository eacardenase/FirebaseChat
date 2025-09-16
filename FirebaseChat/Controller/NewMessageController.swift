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

        setupNavBar()
        setupViews()
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
