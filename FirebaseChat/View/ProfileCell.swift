//
//  ProfileCell.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 10/1/25.
//

import UIKit

class ProfileCell: UITableViewCell {

    // MARK: - Properties

    var viewModel: ProfileViewModel? {
        didSet { configure() }
    }

    private let iconImageView: UIImageView = {
        let _imageView = UIImageView()

        _imageView.translatesAutoresizingMaskIntoConstraints = false
        _imageView.contentMode = .scaleAspectFill
        _imageView.clipsToBounds = true
        _imageView.tintColor = .white

        return _imageView
    }()

    private lazy var iconView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(iconImageView)
        view.backgroundColor = .systemPurple

        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)

        return label
    }()

    // MARK: - View Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Helpers

extension ProfileCell {

    private func setupViews() {
        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)

        // iconView

        let iconViewHeightAnchor = iconView.heightAnchor.constraint(
            equalToConstant: 48
        )
        iconViewHeightAnchor.priority = UILayoutPriority(900)

        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 8
            ),
            iconView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 8
            ),
            iconView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -8
            ),
            iconViewHeightAnchor,
            iconView.widthAnchor.constraint(
                equalToConstant: iconViewHeightAnchor.constant
            ),
        ])

        iconView.layer.cornerRadius = iconViewHeightAnchor.constant / 2

        // iconImageView
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(
                equalTo: iconView.topAnchor,
                constant: 6
            ),
            iconImageView.leadingAnchor.constraint(
                equalTo: iconView.leadingAnchor,
                constant: 6
            ),
            iconImageView.trailingAnchor.constraint(
                equalTo: iconView.trailingAnchor,
                constant: -6
            ),
            iconImageView.bottomAnchor.constraint(
                equalTo: iconView.bottomAnchor,
                constant: -6
            ),
        ])

        // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(
                equalTo: iconView.centerYAnchor
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: iconView.trailingAnchor,
                constant: 8
            ),
        ])
    }

    private func configure() {
        guard let viewModel else { return }

        let imageConf = UIImage.SymbolConfiguration(scale: .medium)

        titleLabel.text = viewModel.description
        iconImageView.image = UIImage(
            systemName: viewModel.iconImage,
            withConfiguration: imageConf
        )
    }

}
