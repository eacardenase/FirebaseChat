//
//  ChatMessageCell.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/25/25.
//

import UIKit

class ChatMessageCell: UICollectionViewCell {

    // MARK: - Properties

    var message: Message? {
        didSet {
            configure()
        }
    }

    var bubbleLeadingAnchor = NSLayoutConstraint()
    var bubbleTrailingAnchor = NSLayoutConstraint()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray

        return imageView
    }()

    private let textView: UITextView = {
        let _textView = UITextView()

        _textView.translatesAutoresizingMaskIntoConstraints = false
        _textView.textColor = .white
        _textView.backgroundColor = .clear
        _textView.font = .systemFont(ofSize: 16)
        _textView.isScrollEnabled = false
        _textView.isEditable = false
        _textView.clipsToBounds = true

        return _textView
    }()

    private let bubbleContainer: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPurple

        return view
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Helpers

extension ChatMessageCell {

    private func setupViews() {
        bubbleContainer.addSubview(textView)

        contentView.addSubview(profileImageView)
        contentView.addSubview(bubbleContainer)

        let profileImageHeightAnchor = profileImageView.heightAnchor.constraint(
            equalToConstant: 32
        )

        // profileImageView
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 8
            ),
            profileImageView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: 8
            ),
            profileImageHeightAnchor,
            profileImageView.widthAnchor.constraint(
                equalTo: profileImageView.heightAnchor
            ),
        ])

        profileImageView.layer.cornerRadius =
            profileImageHeightAnchor.constant / 2

        // bubbleContainer

        bubbleTrailingAnchor = bubbleContainer.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -12
        )
        bubbleLeadingAnchor = bubbleContainer.leadingAnchor.constraint(
            equalTo: profileImageView.trailingAnchor,
            constant: 12
        )

        let bubbleWidthAnchor = bubbleContainer.widthAnchor.constraint(
            lessThanOrEqualToConstant: 250
        )
        bubbleWidthAnchor.priority = UILayoutPriority(900)

        NSLayoutConstraint.activate([
            bubbleContainer.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            bubbleContainer.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            bubbleWidthAnchor,
        ])

        bubbleContainer.layer.cornerRadius = 12

        // textView
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(
                equalTo: bubbleContainer.topAnchor,
                constant: 4
            ),
            textView.leadingAnchor.constraint(
                equalTo: bubbleContainer.leadingAnchor,
                constant: 12
            ),
            textView.trailingAnchor.constraint(
                equalTo: bubbleContainer.trailingAnchor,
                constant: -12
            ),
            textView.bottomAnchor.constraint(
                equalTo: bubbleContainer.bottomAnchor,
                constant: -4
            ),
        ])
    }

    private func configure() {
        guard let message else { return }

        let viewModel = ChatMessageCellViewModel(message: message)

        bubbleContainer.backgroundColor = viewModel.messageBackgroundColor

        textView.text = message.text
        textView.textColor = viewModel.messageTextColor

        bubbleLeadingAnchor.isActive = viewModel.leadingAnchorActive
        bubbleTrailingAnchor.isActive = viewModel.trailingAnchorActive

        profileImageView.isHidden = viewModel.shouldHideProfileImage
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    }

}
