//
//  RegistrationController.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/6/25.
//

import UIKit

class RegistrationController: UIViewController {

    // MARK: - Properties

    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        let imageConf = UIImage.SymbolConfiguration(
            textStyle: .title2,
            scale: .large,
        )
        let image = UIImage(
            systemName: "chevron.left",
            withConfiguration: imageConf
        )

        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setImage(image, for: .normal)
        button.addTarget(
            self,
            action: #selector(backButtonTapped),
            for: .touchUpInside
        )

        return button
    }()

    lazy var addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        let imageConf = UIImage.SymbolConfiguration(pointSize: 70)
        let buttonImage = UIImage(
            systemName: "photo.badge.plus",
            withConfiguration: imageConf
        )

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .white
        button.addTarget(
            self,
            action: #selector(addPhotoButtonTapped),
            for: .touchUpInside
        )

        return button
    }()

    let fullNameTextField: AuthTextField = {
        let textField = AuthTextField(placeholder: "Full Name")

        textField.keyboardType = .asciiCapable

        return textField
    }()

    let emailTextField: AuthTextField = {
        let textField = AuthTextField(placeholder: "Email")

        textField.keyboardType = .emailAddress

        return textField
    }()

    let usernameTextField: AuthTextField = {
        let textField = AuthTextField(placeholder: "Username")

        textField.keyboardType = .asciiCapable

        return textField
    }()

    let passwordTextField: AuthTextField = {
        let textField = AuthTextField(placeholder: "Password", isSecure: true)

        textField.keyboardType = .asciiCapable

        return textField
    }()

    lazy var signUpButton: AuthButton = {
        let button = AuthButton(type: .system)

        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.addTarget(
            self,
            action: #selector(signUpButtonTapped),
            for: .touchUpInside
        )

        return button
    }()

    lazy var showLoginControllerButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(
            string: "Already have an account? ",
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 16),
            ]
        )

        attributedTitle.append(
            NSAttributedString(
                string: "Sign In",
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
            action: #selector(showLoginControllerButtonTapped),
            for: .touchUpInside
        )

        return button
    }()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureGradientLayer()
        setupViews()

        let gestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )

        view.addGestureRecognizer(gestureRecognizer)
    }

}

// MARK: - Helpers

extension RegistrationController {

    private func setupViews() {
        navigationController?.navigationBar.isHidden = true

        let stackView = UIStackView(arrangedSubviews: [
            fullNameTextField,
            emailTextField,
            usernameTextField,
            passwordTextField,
            signUpButton,
        ])

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16

        view.addSubview(backButton)
        view.addSubview(addPhotoButton)
        view.addSubview(stackView)
        view.addSubview(showLoginControllerButton)

        // backButton
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            backButton.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 36
            ),
        ])

        // addProfilePhotoButton
        NSLayoutConstraint.activate([
            addPhotoButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 32
            ),
            addPhotoButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
        ])

        // stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: addPhotoButton.bottomAnchor,
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

        // showLoginControllerButton
        NSLayoutConstraint.activate([
            showLoginControllerButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
            showLoginControllerButton.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
        ])
    }

}

// MARK: - Actions

extension RegistrationController {

    @objc func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @objc func addPhotoButtonTapped(_ sender: UIButton) {
        print(#function)
    }

    @objc func signUpButtonTapped(_ sender: UIButton) {
        print(#function)
    }

    @objc func showLoginControllerButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

}
