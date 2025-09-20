//
//  CustomInputAccessoryView.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/19/25.
//

import UIKit

class CustomInputAccessoryView: UIView {

    // MARK: - Properties

    private let messageInputTextView: UITextView = {
        let textView = UITextView()

        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 16)
        textView.isScrollEnabled = false

        return textView
    }()

    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.systemPurple, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(
            self,
            action: #selector(sendButtonTapped),
            for: .touchUpInside
        )

        return button
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        autoresizingMask = [.flexibleHeight]

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 50)
    }

}

// MARK: - Helpers

extension CustomInputAccessoryView {

    private func setupViews() {
        backgroundColor = .systemPink

        addSubview(messageInputTextView)
        addSubview(sendButton)

        // messageInputTextView
        NSLayoutConstraint.activate([
            messageInputTextView.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 8
            ),
            messageInputTextView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 8
            ),
            messageInputTextView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -8
            ),
        ])

        // sendButton
        NSLayoutConstraint.activate([
            sendButton.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            sendButton.leadingAnchor.constraint(
                equalTo: messageInputTextView.trailingAnchor,
                constant: 8
            ),
            sendButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -8
            ),
            sendButton.heightAnchor.constraint(equalToConstant: 50),
            sendButton.widthAnchor.constraint(equalToConstant: 50),
        ])
    }

}

// MARK: - Actions

extension CustomInputAccessoryView {

    @objc func sendButtonTapped(_ sender: UIButton) {
        print(#function)
    }

}
