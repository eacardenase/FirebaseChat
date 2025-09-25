//
//  ChatController.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/17/25.
//

import UIKit

class ChatController: UICollectionViewController {

    // MARK: - Properties

    private let user: User
    private var messages = [Message]()
    var fromCurrentUser = false

    private lazy var customInputView: CustomInputAccessoryView = {
        let inputView = CustomInputAccessoryView()

        inputView.delegate = self

        return inputView
    }()

    // MARK: - Initializers

    init(user: User) {
        self.user = user

        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override var inputAccessoryView: UIView? {
        return customInputView
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()

        collectionView.alwaysBounceVertical = true
        collectionView.register(
            ChatMessageCell.self,
            forCellWithReuseIdentifier: NSStringFromClass(
                ChatMessageCell.self
            )
        )

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )

        view.addGestureRecognizer(tapGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.prefersLargeTitles = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

// MARK: - Helpers

extension ChatController {

    private func setupViews() {
        collectionView.backgroundColor = .white

        navigationItem.title = user.username
    }

}

// MARK: - Actions

extension ChatController {

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        customInputView.messageInputTextView.resignFirstResponder()
    }

}

// MARK: - UICollectionViewDataSource

extension ChatController {

    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return messages.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NSStringFromClass(ChatMessageCell.self),
                for: indexPath
            ) as? ChatMessageCell
        else {
            fatalError("Could not instantiate ChatMessageCell")
        }

        cell.message = messages[indexPath.row]

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ChatController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }

}

// MARK: - CustomInputAccessoryViewDelegate

extension ChatController: CustomInputAccessoryViewDelegate {

    func inputView(
        _ inputView: CustomInputAccessoryView,
        wantsToSend message: String
    ) {
        inputView.messageInputTextView.text = nil

        fromCurrentUser.toggle()

        let newMessage = Message(
            text: message,
            isFromCurrentUser: fromCurrentUser
        )

        messages.append(newMessage)

        collectionView.reloadData()
    }

}
