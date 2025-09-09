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
        let button = UIButton(type: .system)

        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemPurple.withAlphaComponent(0.5)
        button.layer.cornerRadius = 8
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true

        button.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside
        )

        return button
    }()

    lazy var showRegistrationButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(
            string: "Don't have an account? ",
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 16),
            ]
        )

        attributedTitle.append(
            NSAttributedString(
                string: "Sign Up",
                attributes: [
                    .foregroundColor: UIColor.white,
                    .font: UIFont.boldSystemFont(ofSize: 16),
                ]
            )
        )

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(
            self,
            action: #selector(showRegistrationButtonTapped),
            for: .touchUpInside
        )

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
        view.addSubview(showRegistrationButton)

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

        // showRegistrationButton
        NSLayoutConstraint.activate([
            showRegistrationButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor,
            ),
            showRegistrationButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            ),
        ])
    }

}

// MARK: - Actions

extension LoginController {

    @objc func loginButtonTapped(_ sender: UIButton) {
        print(#function)
    }

    @objc func showRegistrationButtonTapped(_ sender: UIButton) {
        let controller = RegistrationController()

        navigationController?.pushViewController(
            controller,
            animated: true
        )
    }

}
