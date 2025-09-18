//
//  UserSkeletonCell.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/17/25.
//

import UIKit

class UserSkeletonCell: UITableViewCell {

    // MARK: - Properties

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
        label.text = "eacardenase"

        return label
    }()

    private let fullnameLabel: UILabel = {
        let label = UILabel()

        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .lightGray
        label.text = "Edwin Cardenas"

        return label
    }()

    // MARK: - Gradients

    let usernameLayer = CAGradientLayer()
    let fullnameLayer = CAGradientLayer()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupLayers()
        setupAnimation()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()

        usernameLayer.frame = usernameLabel.bounds
        usernameLayer.cornerRadius = usernameLabel.frame.height / 2

        fullnameLayer.frame = usernameLabel.bounds
        fullnameLayer.cornerRadius = usernameLabel.frame.height / 2
    }

}

// MARK: - SkeletonLoadable

extension UserSkeletonCell: SkeletonLoadable {
}

// MARK: - Helpers

extension UserSkeletonCell {

    private func setupViews() {
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

    private func setupLayers() {
        usernameLayer.startPoint = CGPoint(x: 0, y: 0.5)
        usernameLayer.endPoint = CGPoint(x: 1, y: 0.5)
        usernameLabel.layer.addSublayer(usernameLayer)

        fullnameLayer.startPoint = CGPoint(x: 0, y: 0.5)
        fullnameLayer.endPoint = CGPoint(x: 1, y: 0.5)
        fullnameLabel.layer.addSublayer(fullnameLayer)
    }

    private func setupAnimation() {
        let usernameGroup = makeAnimationGroup()
        usernameLayer.add(
            usernameGroup,
            forKey: #keyPath(CAGradientLayer.backgroundColor)
        )

        let fullnameGroup = makeAnimationGroup(previousGroup: usernameGroup)
        fullnameLayer.add(
            fullnameGroup,
            forKey: #keyPath(CAGradientLayer.backgroundColor)
        )
    }

}
