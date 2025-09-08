//
//  LoginController.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/6/25.
//

import UIKit

class LoginController: UIViewController {

    // MARK: - Properties

    let iconImage: UIImageView = {
        let imageView = UIImageView()
        let imageConf = UIImage.SymbolConfiguration(
            pointSize: 70,
            weight: .regular,
            scale: .large
        )

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(
            systemName: "bubble.right",
            withConfiguration: imageConf
        )
        imageView.tintColor = .white

        return imageView
    }()

    let emailContainerView = TextFieldContainerView(
        image: UIImage(systemName: "envelope"),
        placeholder: "Email"
    )

    let passwordContainerView = TextFieldContainerView(
        image: UIImage(systemName: "lock"),
        placeholder: "Password",
        isSecure: true
    )

    lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        var config = UIButton.Configuration.filled()

        config.title = "Log in"
        config.cornerStyle = .medium
        config.baseForegroundColor = .white
        config.baseBackgroundColor = .systemPurple
        config.background.backgroundColorTransformer =
            UIConfigurationColorTransformer({ _ in
                .systemPurple
            })

        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true

        return button
    }()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureGradientLayer()
        setupViews()
    }

}

// MARK: - Helpers

extension LoginController {

    private func configureGradientLayer() {
        let gradient = CAGradientLayer()

        gradient.frame = view.frame
        gradient.colors = [
            UIColor.systemPurple.cgColor, UIColor.systemTeal.cgColor,
        ]

        view.layer.addSublayer(gradient)
    }

    private func setupViews() {
        navigationController?.navigationBar.isHidden = true

        let stackView = UIStackView(arrangedSubviews: [
            emailContainerView,
            passwordContainerView,
            loginButton,
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16

        view.addSubview(iconImage)
        view.addSubview(stackView)

        // iconImage
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 32
            ),
            iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        // stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: iconImage.bottomAnchor,
                constant: 32
            ),
            stackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 32
            ),
            stackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -32
            ),
        ])
    }

}
