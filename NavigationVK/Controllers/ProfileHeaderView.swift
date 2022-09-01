//
//  ProfileHeaderView.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 20.08.2022.
//

import UIKit
import SnapKit

protocol MyClassDelegate: AnyObject {
    func didtap()
}

final class ProfileHeaderView: UIView {
    
        weak var delegate: MyClassDelegate?

        private var statusText: String = ""
        
        lazy var avatarImageView: UIImageView = {
        
        let avatarImageView = UIImageView()
//        avatarImageView.image = UIImage(named: "1")
        avatarImageView.layer.borderWidth = 3
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(expandAvatar))
        avatarImageView.addGestureRecognizer(tapGesture)
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.cornerRadius = 60
        avatarImageView.clipsToBounds = true
        avatarImageView.isUserInteractionEnabled = true
        return avatarImageView
        
    }()
    
    private let fullNameLabel: UILabel = {
        
        let fullNameLabel = UILabel()
        fullNameLabel.text = "Fanil_Jr"
        #if DEBUG
        fullNameLabel.textColor = .black
        #else
        fullNameLabel.textColor = .white
        #endif
        fullNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        return fullNameLabel
        
    }()
    
    private let statusLabel: UILabel = {
        
        let statusLabel = UILabel()
//        statusLabel.text = "Waiting for something..."
        #if DEBUG
        statusLabel.textColor = .black
        statusLabel.shadowColor = .white
        #else
        statusLabel.textColor = .white
        statusLabel.shadowColor = .black
        #endif
        statusLabel.numberOfLines = 0
        statusLabel.font = .systemFont(ofSize: 14, weight: .thin)
        statusLabel.shadowOffset = CGSize(width: 0.5, height: 0.5)
        return statusLabel
            
    }()
        
    private let statusTextField: UITextField = {
            
        let statusTextField = UITextField()
        statusTextField.placeholder = "Введите статус"
        statusTextField.textColor = .black
        statusTextField.font = .systemFont(ofSize: 15, weight: .regular)
        statusTextField.borderStyle = .roundedRect
        statusTextField.clipsToBounds = true
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.backgroundColor = UIColor.white.cgColor
        return statusTextField
            
    }()
        
    private let stackView: UIStackView = {
            
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
            
    }()
    
    private let setStatusButton: CustomButton = {

        let button = CustomButton()
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)

        return button
        }()
    
    
    @objc func expandAvatar() {
            
        UIView.animate(withDuration: 1.3, animations: {
        self.avatarImageView.alpha = 0.0 })
        
        print("нажатие в HeaderView")

        delegate?.didtap()
    }
    
    func snp() {
        
        [avatarImageView, stackView, setStatusButton].forEach { addSubview($0) }
        [fullNameLabel, statusLabel, statusTextField].forEach { stackView.addArrangedSubview($0) }
        
        avatarImageView.snp.makeConstraints { avatar in
            avatar.left.equalTo(0)
            avatar.top.equalTo(0)
            avatar.width.equalTo(120)
            avatar.height.equalTo(120) }
        
        stackView.snp.makeConstraints { stack in
            stack.top.equalTo(0)
            stack.right.equalTo(0)
            stack.left.equalTo(avatarImageView.snp_rightMargin).inset(-30) }
        
        setStatusButton.snp.makeConstraints { button in
            button.top.equalTo(stackView.snp_bottomMargin).inset(-16)
            button.height.equalTo(50)
            button.left.equalTo(0)
            button.right.equalTo(0)
            button.bottom.equalTo(-16) }
        
    }
        
    private func tap() {
        setStatusButton.tapAction =  { [weak self] in
            
            let bounds = self?.setStatusButton.bounds
            let bonds = self?.statusLabel.bounds
            
            /// анимация кнопки setStatus и statusLabel
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: .curveLinear) {
                self?.setStatusButton.bounds = CGRect(x: (bounds?.origin.x)! - 30, y: (bounds?.origin.y)!, width: bounds!.width + 30, height: bounds!.height + 10)
                self?.setStatusButton.titleLabel?.bounds = CGRect(x: bounds!.origin.x, y: bounds!.origin.y, width: bounds!.width + 100, height: bounds!.height)
                self?.statusLabel.bounds = CGRect(x: bonds!.origin.x, y: bonds!.origin.y, width: bonds!.width + 50, height: bonds!.height)
                
            }
            
            self?.statusLabel.text = self?.statusTextField.text
            self?.statusTextField.text = ""
            
            print("Статус установлен")
        }
    }
    
    func setupView(user: User?) {
        
        guard let user = user else {
            print("Не верный Логин")
            avatarImageView.image = UIImage(named: "error")
            fullNameLabel.text = "error"
            return
        }
        
        fullNameLabel.text = user.name
        avatarImageView.image = user.avatar
        statusLabel.text = user.status

    }
        

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        statusTextField.delegate = self
        snp()
        tapScreen()
        tap()
            
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}

extension ProfileHeaderView {
    
    func tapScreen() {
        
        let recognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        recognizer.cancelsTouchesInView = false
        
        addGestureRecognizer(recognizer)
        
    }

    @objc func dismissKeyboard() {
        
        endEditing(true)
        
    }
}

extension ProfileHeaderView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        endEditing(true)
        return true
        
    }
}

