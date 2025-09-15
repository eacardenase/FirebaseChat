//
//  RegistrationController.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/6/25.
//

import UIKit

class RegistrationController: UIViewController {

    // MARK: - Properties

    private var viewModel = RegistrationViewModel()
    private var profileImage: UIImage?

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
        )?.withTintColor(.white, renderingMode: .alwaysOriginal)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(buttonImage, for: .normal)
        button.addTarget(
            self,
            action: #selector(addPhotoButtonTapped),
            for: .touchUpInside
        )

        return button
    }()

    lazy var fullNameTextField: AuthTextField = {
        let textField = AuthTextField(placeholder: "Full Name")

        textField.autocapitalizationType = .words
        textField.keyboardType = .asciiCapable
        textField.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )

        return textField
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

    lazy var usernameTextField: AuthTextField = {
        let textField = AuthTextField(placeholder: "Username")

        textField.keyboardType = .asciiCapable
        textField.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )

        return textField
    }()

    lazy var passwordTextField: AuthTextField = {
        let textField = AuthTextField(placeholder: "Password", isSecure: true)

        textField.keyboardType = .asciiCapable
        textField.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )

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
            usernameTextField,
            emailTextField,
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
            addPhotoButton.widthAnchor.constraint(equalToConstant: 140),
            addPhotoButton.heightAnchor.constraint(equalToConstant: 140),
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

    @objc func textDidChange(_ sender: UITextField) {
        if sender === fullNameTextField {
            viewModel.fullname = sender.text
        } else if sender === usernameTextField {
            viewModel.username = sender.text
        } else if sender === emailTextField {
            viewModel.email = sender.text
        } else if sender === passwordTextField {
            viewModel.password = sender.text
        }

        updateForm()
    }

    @objc func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @objc func addPhotoButtonTapped(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self

        present(imagePickerController, animated: true)
    }

    @objc func signUpButtonTapped(_ sender: UIButton) {
        guard let fullname = viewModel.fullname,
            let username = viewModel.username?.lowercased(),
            let email = viewModel.email?.lowercased(),
            let password = viewModel.password
        else {
            return
        }

        guard let profileImage else {
            let alertController = UIAlertController(
                title: "Profile Photo",
                message: "Please provide an image to be used as profile photo.",
                preferredStyle: .alert
            )

            alertController.addAction(
                UIAlertAction(title: "OK", style: .default)
            )

            present(alertController, animated: true)

            return
        }

        let credentials = RegistrationCredentials(
            email: email,
            password: password,
            fullname: fullname,
            username: username,
            profileImage: profileImage
        )

        showLoader()

        AuthService.createUser(credentials: credentials) { result in
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

    @objc func showLoginControllerButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
{

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey:
            Any]
    ) {
        let image = info[.originalImage] as? UIImage

        profileImage = image

        addPhotoButton.imageView?.contentMode = .scaleAspectFill
        addPhotoButton.clipsToBounds = true
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.height / 2
        addPhotoButton.layer.borderWidth = 1.5
        addPhotoButton.layer.borderColor =
            UIColor.white.cgColor
        addPhotoButton.setImage(
            image?.withRenderingMode(.alwaysOriginal),
            for: .normal
        )

        dismiss(animated: true)
    }

}

// MARK: - AuthenticationControllerProtocol

extension RegistrationController: AuthenticationControllerProtocol {

    func updateForm() {
        signUpButton.isEnabled = viewModel.shouldEnableButton
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
    }

}
