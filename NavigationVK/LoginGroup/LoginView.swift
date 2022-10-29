//
//  LoginView.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 01.09.2022.
//

import Foundation
import UIKit

protocol LoginViewDelegate: AnyObject {
    func didTapLogInButton()
    func didTapSignUpButton()
    func didTapCrackPasswordButton()
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
        image.image = UIImage(named: "vkontakte")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var loginTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Login or email", textColor: .black, font: UIFont.systemFont(ofSize: 16))
        textField.backgroundColor = .systemGray6
        textField.tintColor = UIColor(named: "#4885CC")
        textField.keyboardType = .emailAddress
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return textField
    }()

    private lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Password", textColor: .black, font: UIFont.systemFont(ofSize: 16))
        textField.isSecureTextEntry = true
        textField.tintColor = UIColor(named: "#4885CC")
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return textField
    }()

    let logInButton: CustomButton = {
        let button = CustomButton(title: "Log In", titleColor: .white, backgroundColor: .blue,setBackgroundImage: UIImage(named: "blue_pixel") ?? UIImage())
        return button
    }()
    
    let signInButton: CustomButton = {
        let button = CustomButton(title: "Registration", titleColor: .white, backgroundColor: .blue,setBackgroundImage: UIImage(named: "blue_pixel") ?? UIImage())
        return button
    }()
    
    private let spinnerView: UIActivityIndicatorView = {
        let activityView: UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.hidesWhenStopped = true
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()

    init(delegate: LoginViewDelegate?) {
        super.init(frame: CGRect.zero)
        
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
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
            self?.logInButton.setTitle("", for: .normal)
            self?.delegate?.didTapLogInButton()
            self?.waitingSpinnerEnable(true)
        }
        signInButton.tapAction = { [weak self] in
            guard let self = self else { return }
            self.delegate?.didTapSignUpButton()
        }
    }

    func getLogin() -> String {
        loginTextField.text!
    }

    func getPassword() -> String {
        passwordTextField.text!
    }
    
    func setPassword(password: String, isSecure: Bool) {
        passwordTextField.isSecureTextEntry = isSecure
        passwordTextField.text = password
        }
    
    func waitingSpinnerEnable(_ active: Bool) {
        if active {
            spinnerView.startAnimating()
        } else {
            spinnerView.stopAnimating()
        }
    }

    private func layout() {
        
        [logoImage, loginTextField, passwordTextField, logInButton,signInButton, spinnerView].forEach { contentView.addSubview($0) }
        scrollView.addSubview(contentView)
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 120),
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            
            loginTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor,constant: 120),
            loginTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            loginTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            
            signInButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor,constant: 16),
            signInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            signInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            signInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            spinnerView.centerXAnchor.constraint(equalTo: logInButton.centerXAnchor),
            spinnerView.centerYAnchor.constraint(equalTo: logInButton.centerYAnchor),
        ])
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
