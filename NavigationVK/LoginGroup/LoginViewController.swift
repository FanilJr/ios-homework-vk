//
//  LoginViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 21.08.2022.
//

import UIKit
import SnapKit

protocol LoginViewControllerDelegate: AnyObject {
    func check(login: String, password: String) -> Bool
}

protocol LoginViewDelegate: AnyObject {
    func didTapLogInButton()
}

class LogInViewController: UIViewController {

    private var viewModel: LoginViewModel
    private lazy var loginView = LoginView(delegate: self)
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        layout()
    }

    private func layout() {
        view.addSubview(loginView)

        loginView.snp.makeConstraints{ loginview in
            loginview.top.leading.trailing.bottom.equalToSuperview() }
        
    }


}

extension LogInViewController: LoginViewDelegate {
    
    func didTapLogInButton()  {
        let login = loginView.getLogin()
        let password = loginView.getPassword()
        viewModel.login(login: login, password: password)
        // MARK: При таком условии if login && password != не срабатаывает если ввел правильный логин, поэтому поставил и на пароль условие отельное и н логин, прошу скорректировать меня спасибо за проверку!
        if login != "Fanil_Jr" {
            lazy var alert = UIAlertController(title: "Введите логин и пароль", message: #"""
       #логин: Fanil_Jr \#n #пароль: Netology
       """#, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
            print("где-то ошибка ввода")
        } else {
            print("спасибо Сергей Котов! Настроил вход с алертом")
        }
        
        if password != "Netology" {
            lazy var alert = UIAlertController(title: "Введите логин и пароль", message: #"""
       #логин: Fanil_Jr \#n #пароль: Netology
       """#, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alert, animated: true)
            print("Где-то ошибка ввода")
        } else {
            print("Правильный пароль")
        }
    }

}

        
    