//
//  LoginViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 21.08.2022.
//

import UIKit
//MARK: REALM  import RealmSwift

protocol LoginViewControllerDelegate: AnyObject {
    func checkCredentials(login: String, password: String, success: @escaping (Bool) -> Void) throws
    func signUp(login: String, password: String, success: @escaping (Error?) -> Void) throws
}

class LogInViewController: UIViewController {

    private var viewModel: LoginViewModel
    private lazy var loginView = LoginView(delegate: self)
//MARK: REALM    var logins: Results<LoginModel>?
    
    let background: UIImageView = {
        let back = UIImageView()
        back.image = UIImage(named: "tekstura")
        back.translatesAutoresizingMaskIntoConstraints = false
        return back
    }()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginView.setPassword(password: "", isSecure: true)
//MARK: REALM         if let newData = self.logins?[0] {
//MARK: REALM        viewModel.signUp(login: newData.login, password: newData.password)
//MARK: REALM    }
    }

    private func layout() {
        view.addSubview(background)
        view.addSubview(loginView)
        
        NSLayoutConstraint.activate([
            
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


// MARK: - LoginViewDelegate
extension LogInViewController: LoginViewDelegate {
    
    func didTapSignUpButton() {
        let login = loginView.getLogin()
        let password = loginView.getPassword()

        viewModel.signUp(login: login, password: password)
        DispatchQueue.main.async {
            self.loginView.waitingSpinnerEnable(false)
            self.loginView.logInButton.setTitle("Registration", for: .normal)
        }
    }
    func didTapCrackPasswordButton() {
        print("didTapCRACK")
    }

    func didTapLogInButton() {
        let login = loginView.getLogin()
        let password = loginView.getPassword()
//MARK: REALM
//        let data = LoginModel(value: [login, password])
//        do {
//            let realm = try Realm()
//            try realm.write { realm.add(data) }
//            print("-------------?????? ???????? - ????????????????-------------")
//        } catch let error {
//            print("-----------?????????? ?? ????????????---------------")
//            print(error.localizedDescription)
//        }
        viewModel.login(login: login, password: password)
        DispatchQueue.main.async {
            self.loginView.waitingSpinnerEnable(false)
            self.loginView.logInButton.setTitle("Log in", for: .normal)
        }
    }
}
