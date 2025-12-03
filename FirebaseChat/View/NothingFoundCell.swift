//
//  NothingFoundCell.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 12/3/25.
//

import UIKit

class NothingFoundCell: UITableViewCell {

    // MARK: - Properties

    var title: String? {
        didSet {
            label.text = title
        }
    }

    private var label: UILabel = {
        let _label = UILabel()

        _label.translatesAutoresizingMaskIntoConstraints = false
        _label.font = .preferredFont(forTextStyle: .body)
        _label.textColor = .lightGray
        _label.textAlignment = .center

        return _label
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Helpers

extension NothingFoundCell {

    private func setupViews() {
        contentView.addSubview(label)

        let labelHeightAnchor = label.heightAnchor.constraint(
            equalToConstant: 80
        )
        labelHeightAnchor.priority = UILayoutPriority(900)

        // label
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelHeightAnchor,
        ])
    }

}
