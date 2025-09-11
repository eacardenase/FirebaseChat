//
//  RegistrationViewModel.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/11/25.
//

import UIKit

protocol AuthenticationControllerProtocol {

    func updateForm()

}

protocol AuthenticationProtocol {

    var formIsValid: Bool { get }
    var shouldEnableButton: Bool { get }
    var buttonTitleColor: UIColor { get }
    var buttonBackgroundColor: UIColor { get }

}

extension AuthenticationProtocol {

    var shouldEnableButton: Bool {
        formIsValid
    }

    var buttonTitleColor: UIColor {
        formIsValid ? .white : .white.withAlphaComponent(0.5)
    }

    var buttonBackgroundColor: UIColor {
        formIsValid ? .systemPurple : .systemPurple.withAlphaComponent(0.5)
    }

}

struct RegistrationViewModel: AuthenticationProtocol {

    var email: String?
    var password: String?
    var fullname: String?
    var username: String?

    var formIsValid: Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
            && fullname?.isEmpty == false
            && username?.isEmpty == false
    }

}
