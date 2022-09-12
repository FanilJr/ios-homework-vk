//
//  ProfileHeaderView.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 20.08.2022.
//
import AVFoundation
import UIKit

protocol MyClassDelegate: AnyObject {
    func didtap()
}

protocol SettingsDelegate: AnyObject {
    func settingsMenu()
}

final class ProfileHeaderView: UIView {
    
    
    weak var delegate: MyClassDelegate?
    weak var settingsDelegate: SettingsDelegate?

    private var statusText: String = ""
    let systemSoundID: SystemSoundID = 1016
    
    lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.layer.borderWidth = 3
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(expandAvatar))
        avatarImageView.addGestureRecognizer(tapGesture)
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
        fullNameLabel.textColor = .black
    #else
        fullNameLabel.textColor = .white
    #endif
        fullNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return fullNameLabel
    }()
    
    lazy var settings: UIButton = {
        let button = UIButton()
        //button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.backgroundColor = .white
        button.setBackgroundImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
//        button.image(for: .disabled)
//        button.backgroundColor = .white
//        button.image = UIImage(systemName: "ellipsis.circle")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.layer.cornerRadius = 14
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(showSetting), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private let statusLabel: UILabel = {
        let statusLabel = UILabel()
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
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
        
    private let statusTextField: CustomTextField = {
        let statusTextField = CustomTextField(placeholder: "Введите статус", textColor: .black, font: UIFont.systemFont(ofSize: 15, weight: .regular))
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.backgroundColor = UIColor.white.cgColor
        return statusTextField
    }()
        
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let setStatusButton: CustomButton = {
        let button = CustomButton(title: "Set status", titleColor: .white, backgroundColor: .blue, setBackgroundImage: UIImage(named: "blue_pixel") ?? UIImage())
        return button
        }()
    
    
    @objc func expandAvatar() {
        UIView.animate(withDuration: 1.3, animations: {
        self.avatarImageView.alpha = 0.0 })
        print("нажатие в HeaderView")
        delegate?.didtap()
    }
    
    @objc func showSetting() {
        settingsDelegate?.settingsMenu()
    }
    
    func snp() {
        
        [avatarImageView, stackView, setStatusButton, settings].forEach { addSubview($0) }
        [fullNameLabel, statusLabel, statusTextField].forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarImageView.heightAnchor.constraint(equalToConstant: 120),
            
            settings.topAnchor.constraint(equalTo: stackView.topAnchor),
            settings.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            settings.widthAnchor.constraint(equalToConstant: 28),
            settings.heightAnchor.constraint(equalToConstant: 28),
 
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
//            statusTextField.heightAnchor.constraint(equalToConstant: 30),
//            stackView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            
            setStatusButton.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            setStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -16)
        ])
    }
        
    private func tap() {
        
        setStatusButton.tapAction =  { [weak self] in
            
            AudioServicesPlaySystemSound(self!.systemSoundID)
            
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

//extension ProfileHeaderView: UIContextMenuInteractionDelegate {
//    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
//        return UIContextMenuConfiguration(
//            identifier: nil,
//            previewProvider: nil) { _ in
//                let copy = UIAction(title: "NightTheme") { _ in
//
//            }
//            return UIMenu(title: "Settings", children: [copy])
//        }
//    }
//}
//
//
