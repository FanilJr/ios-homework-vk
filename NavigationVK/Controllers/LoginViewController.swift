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
    
    lazy var loginView = LoginView(delegate: self)
    var delegate: LoginViewControllerDelegate?

    
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

    func didTapLogInButton() {
        let login = loginView.getLogin()
        guard let authorizationSuccessful = delegate?.check(login: login, password: loginView.getPassword()) else { return }
        
               #if DEBUG
                   let userService = CurrentUserService()
               #else
                   let userService = TestUserService()
               #endif
        
               let vc = ProfileViewController(userService: userService, userName: login)
        
               if authorizationSuccessful {
                   navigationController?.pushViewController(vc, animated: true)
               } else {
                   let alert = UIAlertController(title: "Введите логин и пароль", message: #"""
#логин: Fanil_Jr \#n #пароль: Netology
"""#, preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                   present(alert, animated: true)
                   
        }
    }
}


class LoginView: UIView {


    weak var delegate: LoginViewDelegate?
    private let nc = NotificationCenter.default

    private let scrollView: UIScrollView = {

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
        
    }()

    private let contentView: UIView = {

        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
        
    }()

    private let logoImage: UIImageView = {

        let image = UIImageView()
        image.image = UIImage(named: "vk")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()

    private lazy var loginTextField: UITextField = {

        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Login or email"
        textField.tintColor = UIColor(named: "#4885CC")
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftViewMode = UITextField.ViewMode.always
        textField.delegate = self
        textField.leftView = UIView(frame:CGRect(x:0, y:0, width:10, height:textField.frame.height))
        textField.rightView = UIView(frame:CGRect(x:0, y:0, width:10, height:textField.frame.height))
        textField.rightViewMode = .always
        return textField
        
    }()

    private lazy var passwordTextField: UITextField = {

        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.tintColor = UIColor(named: "#4885CC")
        textField.autocapitalizationType = .none
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftViewMode = UITextField.ViewMode.always
        textField.delegate = self
        textField.leftView = UIView(frame:CGRect(x:0, y:0, width:10, height:textField.frame.height))
        textField.rightView = UIView(frame:CGRect(x:0, y:0, width:10, height:textField.frame.height))
        textField.rightViewMode = .always
        return textField
        
    }()

    private let logInButton: CustomButton = {

        let button = CustomButton()
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        switch button.state {
                case .normal:
                    button.alpha = 1
                case .selected:
                    button.alpha = 0.8
                case .highlighted:
                    button.alpha = 0.8
                case .disabled:
                    button.alpha = 0.8
                default:
                    button.alpha = 1
                }
        return button
        
    }()


    init(delegate: LoginViewDelegate?) {
        super.init(frame: CGRect.zero)
        
        backgroundColor = .white
        self.delegate = delegate
        addObserver()
        tapScreen()
        layout()
        taps()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        removeObserver()
    }

    func addObserver() {
        nc.addObserver(self, selector: #selector(kdbShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kdbHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func removeObserver() {
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func kdbShow(notification: NSNotification) {
        
        if let kdbSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = kdbSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kdbSize.height, right: 0)
        }
        
    }

    @objc func kdbHide() {
        
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
        
    }

    private func taps() {
        
        logInButton.tapAction = { [weak self] in
            self?.delegate?.didTapLogInButton()
            
        }
    }

    func getLogin() -> String {
        
        loginTextField.text!
        
    }

    func getPassword() -> String {
        
        passwordTextField.text!
        
    }

    private func layout() {
        
        [logoImage, loginTextField, passwordTextField, logInButton].forEach { contentView.addSubview($0) }

        scrollView.addSubview(contentView)
        addSubview(scrollView)

        logoImage.snp.makeConstraints { logo in
            logo.top.equalTo(contentView.snp.top).offset(120)
            logo.centerX.equalTo(contentView.snp.centerX)
            logo.height.equalTo(100)
            logo.width.equalTo(100) }

        loginTextField.snp.makeConstraints { login in
            login.top.equalTo(logoImage.snp.bottom).offset(120)
            login.leading.equalTo(contentView.snp.leading).offset(16)
            login.trailing.equalTo(contentView.snp.trailing).offset(-16)
            login.height.equalTo(50) }

        passwordTextField.snp.makeConstraints { passwrod in
            passwrod.top.equalTo(loginTextField.snp.bottom)
            passwrod.leading.equalTo(contentView.snp.leading).offset(16)
            passwrod.trailing.equalTo(contentView.snp.trailing).offset(-16)
            passwrod.height.equalTo(50) }

        logInButton.snp.makeConstraints { button in
            button.top.equalTo(passwordTextField.snp.bottom).offset(16)
            button.leading.equalTo(contentView.snp.leading).offset(16)
            button.trailing.equalTo(contentView.snp.trailing).offset(-16)
            button.height.equalTo(50)
            button.bottom.equalTo(contentView.snp.bottom) }

        contentView.snp.makeConstraints { content in
            content.edges.width.equalTo(scrollView) }

        scrollView.snp.makeConstraints{ scroll in
            scroll.edges.equalTo(safeAreaLayoutGuide) }
        
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}

extension LoginView {
    
    func tapScreen() {
        
        let recognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        recognizer.cancelsTouchesInView = false
        
        addGestureRecognizer(recognizer)
        
    }

    @objc func dismissKeyboard() {
        
        endEditing(true)
        
    }
}
