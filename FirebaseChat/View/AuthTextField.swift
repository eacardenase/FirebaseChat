//
//  AuthTextField.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/8/25.
//

import UIKit

class AuthTextField: UITextField {

    // MARK: - Initializers

    init(placeholder: String, isSecure: Bool = false) {
        super.init(frame: .zero)

        let spacerView = UIView()

        spacerView.widthAnchor.constraint(equalToConstant: 12).isActive = true

        leftView = spacerView
        leftViewMode = .always
        rightView = spacerView
        rightViewMode = .always

        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        autocorrectionType = .no
        autocapitalizationType = .none
        tintColor = .white
        backgroundColor = .white.withAlphaComponent(0.1)
        isSecureTextEntry = isSecure
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor.white.withAlphaComponent(0.7)
            ]
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 50)
    }

}
