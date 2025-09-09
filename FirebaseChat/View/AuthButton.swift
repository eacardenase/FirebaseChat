//
//  AuthButton.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/8/25.
//

import UIKit

class AuthButton: UIButton {

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        setTitleColor(.white.withAlphaComponent(0.7), for: .normal)
        isEnabled = false
        backgroundColor = .systemPurple.withAlphaComponent(0.5)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 50)
    }

}
