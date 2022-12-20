//
//  Checker.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 23.08.2022.
//

import Foundation

protocol CheckerServiceProtocol {
    func checkLoginPasswordExists(loginText: String, passwordText: String) -> Bool
}

class CheckerService: CheckerServiceProtocol {
        
    static let shared = CheckerService()
    
    private let login = "ethic91@icloud.com"
    private let password = "Netology"
    
    private init() {}
    
    func checkLoginPasswordExists(loginText: String, passwordText: String) -> Bool {
        guard login.hash == loginText.hash, password.hash == passwordText.hash else { return false }
        
        return true
    }
}
