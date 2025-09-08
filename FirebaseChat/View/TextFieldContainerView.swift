//
//  TextFieldContainerView.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/6/25.
//

import UIKit

class TextFieldContainerView: UIView {

    // MARK: - Properties

    let imageView: UIImageView = {
        let _imageView = UIImageView()

        _imageView.translatesAutoresizingMaskIntoConstraints = false
        _imageView.tintColor = .white
        _imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        _imageView.alpha = 0.87

        return _imageView
    }()

    let textField: UITextField = {
        let _textField = UITextField()

        _textField.translatesAutoresizingMaskIntoConstraints = false
        _textField.textColor = .white
        _textField.tintColor = .white
        _textField.keyboardAppearance = .dark
        _textField.keyboardType = .asciiCapable
        _textField.autocapitalizationType = .none
        _textField.autocorrectionType = .no

        return _textField
    }()

    let dividerView: UIView = {
        let view = UIView()

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white.withAlphaComponent(0.87)

        return view
    }()

    // MARK: - Initializers

    init(image: UIImage?, placeholder: String, isSecure: Bool = false) {
        super.init(frame: .zero)

        imageView.image = image?.withConfiguration(
            UIImage.SymbolConfiguration(scale: .large)
        )

        textField.isSecureTextEntry = isSecure
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor.white.withAlphaComponent(0.5)
            ]
        )

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 50)
    }

}

// MARK: - Helpers

extension TextFieldContainerView {

    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(imageView)
        addSubview(textField)
        addSubview(dividerView)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
        ])

        // textField
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(
                equalTo: imageView.trailingAnchor,
                constant: 8
            ),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: textField.bottomAnchor),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }

}
