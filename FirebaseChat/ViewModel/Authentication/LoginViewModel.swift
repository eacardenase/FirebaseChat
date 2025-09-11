//
//  LoginViewModel.swift
//  FirebaseChat
//
//  Created by Edwin Cardenas on 9/10/25.
//

import Foundation

struct LoginViewModel: AuthenticationProtocol {

    var email: String?
    var password: String?

    var formIsValid: Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
    }

}
