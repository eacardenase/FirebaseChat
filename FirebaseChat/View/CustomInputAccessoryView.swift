//
//  CustomInputAccessoryView.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/19/25.
//

import UIKit

class CustomInputAccessoryView: UIView {

    // MARK: - Properties

    let messageInputTextView: UITextView = {
        let textView = UITextView()

        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        textView.tintColor = .systemPurple
        textView.setContentHuggingPriority(.defaultLow, for: .horizontal)

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

        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.setContentCompressionResistancePriority(
            .required,
            for: .horizontal
        )

        return button
    }()

    private let placeholderLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter message..."
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray

        return label
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        autoresizingMask = [.flexibleHeight]

        setupViews()
        addShadow()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChange),
            name: UITextView.textDidChangeNotification,
            object: nil
        )
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
        backgroundColor = .white

        addSubview(messageInputTextView)
        addSubview(sendButton)
        addSubview(placeholderLabel)

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
                constant: -16
            ),
        ])

        // placeholderLabel
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(
                equalTo: messageInputTextView.leadingAnchor,
                constant: 8
            ),
            placeholderLabel.centerYAnchor.constraint(
                equalTo: messageInputTextView.centerYAnchor
            ),
        ])
    }

    private func addShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -8)
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 8
    }

}

// MARK: - Actions

extension CustomInputAccessoryView {

    @objc func sendButtonTapped(_ sender: UIButton) {
        print(#function)
    }

    @objc func textDidChange(_ sender: NSNotification) {
        placeholderLabel.isHidden = !messageInputTextView.text.isEmpty
    }

}
