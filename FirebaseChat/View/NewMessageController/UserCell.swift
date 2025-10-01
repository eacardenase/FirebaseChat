//
//  UserCell.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/16/25.
//

import SDWebImage
import UIKit

class UserCell: UITableViewCell {

    // MARK: - Properties

    var user: User? {
        didSet {
            configure()
        }
    }

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemPurple.withAlphaComponent(0.5)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()

        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .black

        return label
    }()

    private let fullnameLabel: UILabel = {
        let label = UILabel()

        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .lightGray

        return label
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Helpers

extension UserCell {

    private func setupViews() {
        backgroundColor = .white

        let stackView = UIStackView(arrangedSubviews: [
            usernameLabel,
            fullnameLabel,
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 4

        contentView.addSubview(profileImageView)
        contentView.addSubview(stackView)

        let profileImageHeightAnchor = profileImageView.heightAnchor.constraint(
            equalToConstant: 56
        )
        profileImageHeightAnchor.priority = UILayoutPriority(900)

        // profileImageView
        NSLayoutConstraint.activate([
            profileImageHeightAnchor,
            profileImageView.widthAnchor.constraint(
                equalTo: profileImageView.heightAnchor
            ),
            profileImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 8
            ),
            profileImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 16
            ),
            profileImageView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -8
            ),
        ])

        // stackView
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(
                equalTo: contentView.centerYAnchor
            ),
            stackView.leadingAnchor.constraint(
                equalTo: profileImageView.trailingAnchor,
                constant: 16
            ),
        ])

        profileImageView.layer.cornerRadius =
            profileImageHeightAnchor.constant / 2
    }

    private func configure() {
        guard let user else { return }

        let viewModel = UserCellViewModel(user: user)

        usernameLabel.text = viewModel.username
        fullnameLabel.text = viewModel.fullname

        guard let url = URL(string: user.profileImageUrl) else { return }

        profileImageView.sd_setImage(with: url)
    }

}
