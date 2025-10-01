//
//  ProfileHeader.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/30/25.
//

import UIKit

protocol ProfileHeaderDelegate: AnyObject {

    func dismissController()

}

class ProfileHeader: UIView {

    // MARK: - Properties

    var user: User? {
        didSet { configure() }
    }

    weak var delegate: ProfileHeaderDelegate?

    lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()

        gradient.locations = [0.5, 1]
        gradient.colors = [
            UIColor.systemPurple.cgColor,
            UIColor.systemTeal.cgColor,
        ]

        return gradient
    }()

    private lazy var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        let imageConf = UIImage.SymbolConfiguration(
            pointSize: 20,
            weight: .bold,
            scale: .large
        )

        let image = UIImage(systemName: "xmark", withConfiguration: imageConf)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.addTarget(
            self,
            action: #selector(dismissButtonTapped),
            for: .touchUpInside
        )

        return button
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 2

        return imageView
    }()

    private let fullnameLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        label.textColor = .white

        return label
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .white
        label.textAlignment = .center

        return label
    }()

    // MARK: - View Lifecycle

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 380))

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        gradientLayer.frame = bounds
    }

}

// MARK: - Helpers

extension ProfileHeader {

    private func setupViews() {
        layer.addSublayer(gradientLayer)

        let stackView = UIStackView(arrangedSubviews: [
            fullnameLabel,
            usernameLabel,
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 2

        addSubview(dismissButton)
        addSubview(profileImageView)
        addSubview(stackView)

        // dismissButton
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 8
            ),
            dismissButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
        ])

        // profileImageView

        let profileImageHeightAnchor = profileImageView.heightAnchor.constraint(
            equalToConstant: 200
        )

        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageHeightAnchor,
            profileImageView.widthAnchor.constraint(
                equalToConstant: profileImageHeightAnchor.constant
            ),
        ])

        profileImageView.layer.cornerRadius =
            profileImageHeightAnchor.constant / 2

        // stackView
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.topAnchor.constraint(
                equalTo: profileImageView.bottomAnchor,
                constant: 16
            ),
        ])
    }

    private func configure() {
        guard let user else { return }

        let viewModel = ProfileHeaderViewModel(profile: user)

        fullnameLabel.text = viewModel.fullname
        usernameLabel.text = viewModel.username

        guard let url = viewModel.profileImageUrl else { return }

        profileImageView.sd_setImage(with: url)
    }

}

// MARK: - Actions

extension ProfileHeader {

    @objc func dismissButtonTapped(_ sender: UIButton) {
        delegate?.dismissController()
    }

}
