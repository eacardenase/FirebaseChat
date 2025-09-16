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

        setupViews()
    }

}

// MARK: - Helpers

extension NewMessageController {

    private func setupViews() {
        view.backgroundColor = .systemPink
    }

}
