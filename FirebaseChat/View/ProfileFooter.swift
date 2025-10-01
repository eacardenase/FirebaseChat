//
//  ProfileFooter.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 10/1/25.
//

import UIKit

protocol ProfileFooterDelegate: AnyObject {

    func handleLogout()

}

class ProfileFooter: UIView {

    // MARK: - Properties

    weak var delegate: ProfileFooterDelegate?

    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.addTarget(
            self,
            action: #selector(logoutButtonTapped),
            for: .touchUpInside
        )

        return button
    }()

    // MARK: - View Lifecycle

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 100))

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Helpers

extension ProfileFooter {

    private func setupViews() {
        addSubview(logoutButton)

        // logoutButton
        NSLayoutConstraint.activate([
            logoutButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoutButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 32
            ),
            logoutButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -32
            ),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

}

// MARK: - Actions

extension ProfileFooter {

    @objc func logoutButtonTapped(_ sender: UIButton) {
        delegate?.handleLogout()
    }

}
