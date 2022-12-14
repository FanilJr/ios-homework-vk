//
//  ProfileImageView.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 16.09.2022.
//

import UIKit

protocol SettingsDelegate: AnyObject {
    func tapClosed()
    func openSetting()
}

class ProfileImageView: UIView {
    
    weak var settingDelegate: SettingsDelegate?
    
    private var background: UIImageView = {
        let background = UIImageView()
        background.layer.cornerRadius = 30
        background.image = UIImage(named: "backAvatar")
        background.clipsToBounds = true
        background.contentMode = .scaleAspectFill
        background.layer.borderColor = UIColor.white.cgColor
        background.layer.borderWidth = 3
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 12
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.cornerRadius = 60
        avatarImageView.clipsToBounds = true
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        return avatarImageView
    }()
    
    private let fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.text = "Fanil_Jr"
    #if DEBUG
        fullNameLabel.textColor = .white
    #else
        fullNameLabel.textColor = .black
    #endif
        fullNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return fullNameLabel
    }()
    
    private let settingsButton: UIButton = {
        let settings = UIButton()
        settings.setImage(UIImage(systemName: "gear"), for: .normal)
        settings.setTitle("??????????????????", for: .normal)
        settings.setTitleColor(.white, for: .normal)
        settings.tintColor = .cyan
        settings.translatesAutoresizingMaskIntoConstraints = false
        settings.clipsToBounds = true
        settings.addTarget(self, action: #selector(tapSetting), for: .touchUpInside)
        return settings
    }()
    
    private let creditCard: UIButton = {
        let card = UIButton()
        card.setImage(UIImage(systemName: "creditcard"), for: .normal)
        card.setTitle("????????: RUB", for: .normal)
        card.setTitleColor(.white, for: .normal)
        card.tintColor = .cyan
        card.translatesAutoresizingMaskIntoConstraints = false
        card.clipsToBounds = true
        return card
    }()
    
    private let closedButton: UIButton = {
        let closed = UIButton()
        closed.setImage(UIImage(systemName: "clear"), for: .normal)
        closed.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        closed.setTitle("??????????", for: .normal)
        closed.setTitleColor(.white, for: .normal)
        closed.tintColor = .red
        closed.translatesAutoresizingMaskIntoConstraints = false
        closed.addTarget(self, action: #selector(tapClosed), for: .touchUpInside)
        closed.clipsToBounds = true
        return closed
    }()
    
    @objc func tapClosed() {
        settingDelegate?.tapClosed()
    }
    
    @objc func tapSetting() {
        settingDelegate?.openSetting()
    }
    
    func layoutView() {
        
        [creditCard, settingsButton].forEach { stack.addArrangedSubview($0) }
        [background, avatarImageView, fullNameLabel, stack, closedButton].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            avatarImageView.topAnchor.constraint(equalTo: background.topAnchor,constant: -60),
            avatarImageView.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarImageView.heightAnchor.constraint(equalToConstant: 120),
            
            fullNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor,constant: 5),
            fullNameLabel.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            stack.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor,constant: 30),
            stack.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            
            closedButton.topAnchor.constraint(equalTo: stack.bottomAnchor,constant: 30),
            closedButton.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            closedButton.leadingAnchor.constraint(equalTo: background.leadingAnchor),
            closedButton.trailingAnchor.constraint(equalTo: background.trailingAnchor)
        ])
    }
    
    func setGradientBackground() {
        let colorTop = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
    }
    
    func setupView(user: User?) {
        guard let user = user else {print("Error: User nil in ProfileHeaderView." + #function); return}
        avatarImageView.image = user.avatar
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layoutView()
        self.layer.cornerRadius = 30
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 30
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
