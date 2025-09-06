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

    let emailContainerView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemCyan
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true

        return view
    }()

    let passwordContainerView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemYellow
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true

        return view
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log in", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.backgroundColor = .systemRed
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
