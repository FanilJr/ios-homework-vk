//
//  RegistrationViewModel.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 14.12.2022.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore

protocol RegistrationViewModelProtocol {
    var onStateChanged: ((RegistrationViewModel.State) -> Void)? { get set }
    var showMainVc: ((String, String) -> Void)? { get set }
    func send(_ action: RegistrationViewModel.Action)
}

final class RegistrationViewModel {
    var onStateChanged: ((State) -> Void)?
    var showMainVc: ((String, String) -> Void)?
    
    private let auth = Auth.auth()
    private let ud = UserDefaults.standard
    private let firebaseSevice = FirebaseService()
    
    private var state: State = .initial {
        didSet {
            onStateChanged?(state)
        }
    }
    
    func send(_ action: RegistrationViewModel.Action) {
        switch action {
        case .showMainVc(let email, let password):
            guard let email = email, !email.isEmpty else {
                state = .showEmptyAlert(RegistrationError.incorrectEmail.localizedDescription)
                return
            }
            guard let password = password, !password.isEmpty else {
                state = .showEmptyAlert(RegistrationError.incorrectPassword.localizedDescription)
                return
            }
            
            firebaseSevice.createUser(email: email, password: password, completion: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(_):
                    self.showMainVc?(email, password)
                case .failure(let error):
                    self.state = .showEmptyAlert(error.localizedDescription)
                }
            })
        }
    }
}

extension RegistrationViewModel {
    enum Action {
        case showMainVc(String?, String?)
    }
    
    enum State {
        case initial
        case showEmptyAlert(String)
    }
}

enum RegistrationError: Error {
    case incorrectEmail
    case incorrectPassword
}

extension RegistrationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .incorrectEmail:
            return "Incorrect email"
        case .incorrectPassword:
            return "Incorrect password"
        }
    }
}
