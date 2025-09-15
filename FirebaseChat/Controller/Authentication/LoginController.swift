//
//  LoginController.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/6/25.
//

import JGProgressHUD
import UIKit

class LoginController: UIViewController {

    // MARK: - Properties

    private var viewModel = LoginViewModel()

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

    lazy var emailTextField: AuthTextField = {
        let textField = AuthTextField(placeholder: "Email")

        textField.keyboardType = .emailAddress
        textField.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )

        return textField
    }()

    lazy var passwordTextField: AuthTextField = {
        let textField = AuthTextField(
            placeholder: "Password",
            isSecure: true
        )

        textField.keyboardType = .asciiCapable
        textField.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )

        return textField
    }()

    lazy var loginButton: AuthButton = {
        let button = AuthButton(type: .system)

        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
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

        let gestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )

        view.addGestureRecognizer(gestureRecognizer)
    }

}

// MARK: - Helpers

extension LoginController {

    private func setupViews() {
        navigationController?.navigationBar.isHidden = true

        let stackView = UIStackView(arrangedSubviews: [
            emailTextField,
            passwordTextField,
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

    @objc func textDidChange(_ sender: UITextField) {
        if sender === emailTextField {
            viewModel.email = sender.text
        } else if sender === passwordTextField {
            viewModel.password = sender.text
        }

        updateForm()
    }

    @objc func loginButtonTapped(_ sender: UIButton) {
        guard let email = viewModel.email,
            let password = viewModel.password
        else {
            return
        }

        showLoader()

        AuthService.logUserIn(withEmail: email, password: password) { result in
            switch result {
            case .success:
                self.dismiss(animated: true)
            case .failure(let error):
                if case .serverError(let message) = error {
                    let alertController = UIAlertController(
                        title: "Error",
                        message: message,
                        preferredStyle: .alert
                    )
                    alertController.addAction(
                        UIAlertAction(title: "OK", style: .default)
                    )

                    self.present(alertController, animated: true)
                }
            }

            self.showLoader(false)
        }
    }

    @objc func showRegistrationButtonTapped(_ sender: UIButton) {
        let controller = RegistrationController()

        navigationController?.pushViewController(
            controller,
            animated: true
        )
    }

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

}

// MARK: - AuthenticationControllerProtocol

extension LoginController: AuthenticationControllerProtocol {

    func updateForm() {
        loginButton.isEnabled = viewModel.shouldEnableButton
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        
        print("This should not be printed.")
    }

}
