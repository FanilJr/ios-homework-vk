//
//  LoginInspector.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 23.08.2022.
//

import Foundation

enum LoginError: Error {
    case loginIsEmpty
    case loginIsIncorrect
    case passwordIsEmpty
    case passwordIsIncorrect
    case isInvalid
}

class LoginInspector: LoginViewControllerDelegate {

    func checkCredentials(login: String, password: String, success: @escaping (Bool) -> Void) throws {
        Checker.shared.checkCredentials(login: login, password: password) { result in
            success(result)
        }

        switch (login, password) {
        case ("", _):
            throw LoginError.loginIsEmpty
        case (_, ""):
            throw LoginError.passwordIsEmpty
        default:
            break
        }
    }

    func signUp(login: String, password: String, success: @escaping (Error?) -> Void) throws {
        Checker.shared.signUp(login: login, password: password) { result in
            success(result)
        }

        switch (login, password) {
        case ("", _):
            throw LoginError.loginIsEmpty
        case (_, ""):
            throw LoginError.passwordIsEmpty
        default:
            break
        }
    }
}
