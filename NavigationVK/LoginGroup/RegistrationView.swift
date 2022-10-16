//
//  RegistrationView.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 15.10.2022.
//

import UIKit
import Firebase


protocol RegistrationViewDelegate: AnyObject {
    func didTapRegistrationButton()
}
class RegistrationView: UIView {
    
    weak var delegate: RegistrationViewDelegate?
    
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "vk")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var loginTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Укажите Email", textColor: .black, font: UIFont.systemFont(ofSize: 16))
        textField.backgroundColor = .systemGray6
        textField.tintColor = UIColor(named: "#4885CC")
        textField.keyboardType = .emailAddress
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return textField
    }()
    
    private lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Придумайте пароль", textColor: .black, font: UIFont.systemFont(ofSize: 16))
        textField.isSecureTextEntry = true
        textField.tintColor = UIColor(named: "#4885CC")
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return textField
    }()
    
    let logInButton: CustomButton = {
        let button = CustomButton(title: "Регистрация", titleColor: .white, backgroundColor: .blue,setBackgroundImage: UIImage(named: "blue_pixel") ?? UIImage())
        return button
    }()
    
    init(delegate: RegistrationViewDelegate?) {
        super.init(frame: CGRect.zero)
        self.delegate = delegate
        translatesAutoresizingMaskIntoConstraints = false
        layout()
        taps()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func taps() {
        logInButton.tapAction = { [weak self] in
            self?.delegate?.didTapRegistrationButton()
        }
    }
    
    private func layout() {
        [logoImage, loginTextField,passwordTextField, logInButton].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: topAnchor,constant: 120),
            logoImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            
            loginTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor,constant: 120),
            loginTextField.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            loginTextField.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,constant: 16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16)
        ])
    }
}

extension RegistrationView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let email = loginTextField.text!
        let password = passwordTextField.text!
        if email.isEmpty && password.isEmpty == true {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if error == nil {
                    if let result = result {
                        print(result.user.uid)
//                        let ref = Database.database().reference().child("users")
                    }
                }
            }
        }
        return true
    }
}
