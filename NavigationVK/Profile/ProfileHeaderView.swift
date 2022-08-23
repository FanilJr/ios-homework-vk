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

class ProfileHeaderView: UIView {
    
        weak var delegate: MyClassDelegate?

        private var statusText: String = ""
        
        lazy var avatarImageView: UIImageView = {
        
        let avatarImageView = UIImageView()
        avatarImageView.image = UIImage(named: "1")
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
        fullNameLabel.textColor = .black
        fullNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        return fullNameLabel
        
    }()
    
    private let statusLabel: UILabel = {
        
        let statusLabel = UILabel()
        statusLabel.text = "Waiting for something..."
        statusLabel.textColor = .gray
        statusLabel.font = .systemFont(ofSize: 14, weight: .regular)
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
        
    private lazy var setStatusButton: UIButton = {
            
        let setStatusButton = UIButton()
        setStatusButton.setTitle("Set status", for: .normal)
        setStatusButton.setTitleColor(.white, for: .normal)
        setStatusButton.layer.cornerRadius = 12
        setStatusButton.backgroundColor = .systemBlue
        setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setStatusButton.layer.shadowRadius = 4
        setStatusButton.layer.shadowColor = UIColor.black.cgColor
        setStatusButton.layer.shadowOpacity = 0.7
        setStatusButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
        return setStatusButton
            
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
        
    @objc private func tap() {
        
        let bounds = setStatusButton.bounds
        let bonds = statusLabel.bounds
               
               /// анимация кнопки setStatus и statusLabel
               UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: .curveLinear) {
                   self.setStatusButton.bounds = CGRect(x: bounds.origin.x - 30, y: bounds.origin.y, width: bounds.width + 30, height: bounds.height + 10)
                   self.setStatusButton.titleLabel?.bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.width + 100, height: bounds.height)
                   self.statusLabel.bounds = CGRect(x: bonds.origin.x, y: bonds.origin.y, width: bonds.width + 50, height: bonds.height)
                   
               }
            
        statusLabel.text = statusTextField.text
        statusTextField.text = ""
        
        print("Статус установлен")
            
    }
        

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        snp()
            
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
