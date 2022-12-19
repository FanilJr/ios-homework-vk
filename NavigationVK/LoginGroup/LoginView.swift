//
//  LoginView.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 01.09.2022.
//

import Foundation
import UIKit


class LoginView: UIView {

    weak var delegate: LogInViewControllerDelegate?
    weak var checkerDelegate: LogInViewControllerCheckerDelegate?
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
        let textField = CustomTextField(placeholder: "Login or email", textColor: .createColor(light: .black, dark: .white), font: UIFont.systemFont(ofSize: 16))
        textField.backgroundColor = .systemGray6
        textField.tintColor = UIColor(named: "#4885CC")
        textField.keyboardType = .emailAddress
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return textField
    }()

    private lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Password", textColor: .createColor(light: .black, dark: .white), font: UIFont.systemFont(ofSize: 16))
        textField.isSecureTextEntry = true
        textField.tintColor = UIColor(named: "#4885CC")
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return textField
    }()

    lazy var logInButton: CustomButton = {
        logInButton = CustomButton(title: "LogIn", titleColor: .white, onTap: { [weak self] in
                self?.tappedButton()
            })
        logInButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        logInButton.layer.cornerRadius = 14
        logInButton.layer.masksToBounds = true
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        
        return logInButton
    }()
    
    private lazy var signUpButton: CustomButton = {
        signUpButton = CustomButton(title: "SignUp", titleColor: .white, onTap: { [weak self] in
                self?.signUpTapped()
            })
        signUpButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        signUpButton.layer.cornerRadius = 14
        signUpButton.layer.masksToBounds = true
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        return signUpButton
    }()
    
    private lazy var biometryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.3322684266, green: 0.2863991261, blue: 0.3659052849, alpha: 1)
        button.setBackgroundImage(UIImage(named: "faceid@100x"), for: .normal)
        button.addTarget(self, action: #selector(biometryTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        return button
    }()

    
    private let spinnerView: UIActivityIndicatorView = {
        let activityView: UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.hidesWhenStopped = true
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        addObserver()
        tapScreen()
        layout()
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

    private func tappedButton() {
        guard let vc = self.window?.rootViewController else { return }

        guard let emailText = loginTextField.text, !emailText.isEmpty else {
            CommonAlertError.present(vc: vc, with: "Input correct email")
            return
        }
        guard let passwordText = passwordTextField.text, !passwordText.isEmpty else {
            CommonAlertError.present(vc: vc, with: "Input correct password")
            return
        }
        
        checkerDelegate?.login(inputLogin: emailText, inputPassword: passwordText, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.delegate?.tappedButton(fullName: emailText)
            case .failure(let error):
                CommonAlertError.present(vc: vc, with: error.localizedDescription)
            }
        })
    }

    
    private func signUpTapped() {
        delegate?.pushSignUp()
    }
    
    @objc private func biometryTapped() {
        guard let vc = self.window?.rootViewController else { return }

        let local = LocalAuthorizationService()
        local.authorizeIfPossible { [weak self] flag in
            if flag {
                self?.delegate?.tappedButton(fullName: "header.name".localized)
            } else {
                CommonAlertError.present(vc: vc, with: "Error in biometry authorized!")
            }
        }
    }
    
    func waitingSpinnerEnable(_ active: Bool) {
        if active {
            spinnerView.startAnimating()
        } else {
            spinnerView.stopAnimating()
        }
    }

    private func layout() {
        
        [logoImage, loginTextField, passwordTextField, logInButton, signUpButton, biometryButton].forEach { contentView.addSubview($0) }
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
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
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
//
            signUpButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor,constant: 16),
            signUpButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            signUpButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
//            signUpButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            biometryButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor,constant: 150),
            biometryButton.widthAnchor.constraint(equalToConstant: 70),
            biometryButton.heightAnchor.constraint(equalToConstant: 70),
            biometryButton.centerXAnchor.constraint(equalTo: logInButton.centerXAnchor),
            biometryButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
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
