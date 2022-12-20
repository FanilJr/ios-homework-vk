//
//  LoginViewModel.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 01.09.2022.
//

import Foundation

final class LoginViewModel {
    var showProfileVc: ((String) -> Void)?
    var showRegistrationVc: (() -> Void)?

    func send(_ action: Action){
        switch action {
        case .showProfileVc(let title):
            showProfileVc?(title)
        case .showRegistrationVc:
            showRegistrationVc?()
        }
    }
}

extension LoginViewModel {
    enum Action {
        case showProfileVc(String)
        case showRegistrationVc
    }
}
