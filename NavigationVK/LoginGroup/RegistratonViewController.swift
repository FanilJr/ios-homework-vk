//
//  RegistratonViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 15.10.2022.
//

import UIKit

class RegistratonViewController: UIViewController {
    
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "vkontakte")
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
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Придумайте пароль", textColor: .black, font: UIFont.systemFont(ofSize: 16))
        textField.isSecureTextEntry = true
        textField.tintColor = UIColor(named: "#4885CC")
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var continueButton: CustomButton = {
        continueButton = CustomButton(title: "registration.continue".localized, titleColor: .white, onTap: { [weak self] in
                self?.continueTapped()
            })
        continueButton.setBackgroundImage(
            UIImage(named: "blue_pixel"), for: .normal)
        continueButton.layer.cornerRadius = 10
        continueButton.layer.masksToBounds = true
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        return continueButton
    }()
    
    private let viewModel: RegistrationViewModel
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func continueTapped() {
        let email = self.loginTextField.text
        let password = self.passwordTextField.text
        viewModel.send(.showMainVc(email, password))
    }
    
    private func layout() {
        [logoImage, loginTextField,passwordTextField, continueButton].forEach { view.addSubview($0) }
            
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.topAnchor,constant: 120),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            
            loginTextField.topAnchor.constraint(equalTo: logoImage.bottomAnchor,constant: 120),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            loginTextField.heightAnchor.constraint(equalToConstant: 45),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 45),
            
            continueButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,constant: 16),
            continueButton.heightAnchor.constraint(equalToConstant: 45),
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16)
        ])
    }
}

private extension RegistratonViewController {
    private func setupViewModel() {
        viewModel.onStateChanged = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .initial:
                print("initial")
            case .showEmptyAlert(let error):
                CommonAlertError.present(vc: self, message: error)
            }
        }
    }
}
