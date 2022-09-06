//
//  LoginViewModel.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 01.09.2022.
//

import Foundation
import UIKit

final class LoginViewModel {
    
    private let loginInspector: LoginInspector
    private let coordinator: ProfileFlowCoordinator
   
    init(loginFactory: LoginFactory, coordinator: ProfileFlowCoordinator) {
        self.loginInspector = loginFactory.makeLoginInspector()
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func login(login: String, password: String) {
        let authorizationSuccessful = LoginInspector().check(login: login, password: password)
        if authorizationSuccessful {
            coordinator.showProfile(userName: login)
        } else {
            print("Логин: Fanil_Jr, пароль: Netology")
        }
    }
}
