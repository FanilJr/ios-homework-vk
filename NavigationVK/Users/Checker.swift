//
//  Checker.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 23.08.2022.
//

import Foundation
import FirebaseAuth
import AVFoundation

protocol CheckerServiceProtocol {
    func checkCredentials(login: String, password: String, success: @escaping (Bool) -> Void)
    func signUp(login: String, password: String, response: @escaping (Error?) -> Void)
}
class Checker: CheckerServiceProtocol {
    
    static let shared = Checker()
    
    private let login = "Fanil_Jr"
    private let password = "Netology"
    
    private init() {}
    
    func authorization(login: String, password: String) -> Bool {
        return self.login.hash == login.hash && self.password.hash == password.hash
    }

    func checkCredentials(login: String, password: String, success: @escaping (Bool) -> Void) {
        FirebaseAuth.Auth.auth().signIn(withEmail: login, password: password) { result, error in
            success(error == nil)
        }
    }

    func signUp(login: String, password: String, response: @escaping (Error?) -> Void) {
        FirebaseAuth.Auth.auth().createUser(withEmail: login, password: password) { result, error in
            response(error)
        }
    }
}
