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

class LogInViewController: UIViewController {

    //MARK: - Properties
    
    lazy var loginView = LoginView(delegate: self)
    var delegate: LoginViewControllerDelegate?

    //MARK: - LifeCicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }

    //MARK: - Metods
    
    private func layout() {
        view.addSubview(loginView)

        loginView.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }

}

//MARK: - LoginViewDelegate
extension LogInViewController: LoginViewDelegate {

    func didTapLogInButton() {
        let login = loginView.getLogin()
        guard let authorizationSuccessful = delegate?.check(login: login, password: loginView.getPassword()) else {
                   print("File:" + #file, "\nFunction: " + #function + "\nError message: Не удалось выполнить проверку пары Логин/Пароль\n")
                   return
               }
               #if DEBUG
                   let userService = CurrentUserService()
               #else
                   let userService = TestUserService()
               #endif
               let vc = ProfileViewController(userService: userService, userName: login)
               if authorizationSuccessful {
                   navigationController?.pushViewController(vc, animated: true)
               } else {
                   print("File:" + #file, "\nFunction: " + #function + "\nError message: Пара Логин/Пароль не найдена\n")
               }
    }


}

protocol LoginViewDelegate: AnyObject {
    func didTapLogInButton()
}

class LoginView: UIView {

    //MARK: - Properties
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
        textField.placeholder = "Email or phone"
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

        let button = CustomButton(title: "Log In", titleColor: .white, backgroundColor: .blue)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        
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
        button.layer.cornerRadius = 10
        button.clipsToBounds = true

        return button
    }()

    //MARK: - LifeCicle
    init(delegate: LoginViewDelegate?) {
        super.init(frame: CGRect.zero)
        self.delegate = delegate
        backgroundColor = .white
        addObserver()
        layout()
        taps()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        removeObserver()
    }

    //MARK: - Metods
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

    func getLogin() -> String{
        loginTextField.text!
    }

    func getPassword() -> String{
        passwordTextField.text!
    }

    private func layout() {
        [logoImage,
         loginTextField,
         passwordTextField,
         logInButton
        ].forEach { contentView.addSubview($0)}

        scrollView.addSubview(contentView)
        addSubview(scrollView)

        logoImage.snp.makeConstraints{
            $0.top.equalTo(contentView.snp.top).offset(120)
            $0.centerX.equalTo(contentView.snp.centerX)
            $0.height.equalTo(100)
            $0.width.equalTo(100)
        }

        loginTextField.snp.makeConstraints{
            $0.top.equalTo(logoImage.snp.bottom).offset(120)
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-16)
            $0.height.equalTo(50)
        }

        passwordTextField.snp.makeConstraints{
            $0.top.equalTo(loginTextField.snp.bottom)
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-16)
            $0.height.equalTo(50)
        }

        logInButton.snp.makeConstraints{
            $0.top.equalTo(passwordTextField.snp.bottom).offset(16)
            $0.leading.equalTo(contentView.snp.leading).offset(16)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-16)
            $0.height.equalTo(50)
            $0.bottom.equalTo(contentView.snp.bottom)
        }

        contentView.snp.makeConstraints{
            $0.edges.width.equalTo(scrollView)
        }

        scrollView.snp.makeConstraints{
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}

//MARK: - UITextFieldDelegate
extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}
