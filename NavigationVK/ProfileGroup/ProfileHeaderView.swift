//
//  ProfileHeaderView.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 20.08.2022.
//
import AVFoundation
import UIKit

protocol MyClassDelegate: AnyObject {
    func presentMenuAvatar()
    func presentSettings()
    func postCountsPresent()
    func imagePresentPicker()
    func changeName()
    func changeStatus()
}

final class ProfileHeaderView: UIView {
    
    weak var delegate: MyClassDelegate?
    private var statusText: String = ""
    let systemSoundID: SystemSoundID = 1016
    let posts = PostAPI.getPosts()
    private var imageViewHeight = NSLayoutConstraint()
    private var imageViewBottom = NSLayoutConstraint()
    private var containerView = UIView()
    private var containerViewHeight = NSLayoutConstraint()
    
    lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(expandAvatar))
        avatarImageView.addGestureRecognizer(tapGesture)
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        return avatarImageView
    }()
    
    let fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.text = "header.name".localized
        fullNameLabel.textColor = UIColor.createColor(light: .white, dark: .white)
        fullNameLabel.numberOfLines = 0
        fullNameLabel.font = .systemFont(ofSize: 60, weight: .bold)
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return fullNameLabel
    }()
    
    let statusLabel: UILabel = {
        let statusLabel = UILabel()
        statusLabel.textColor = UIColor.createColor(light: .white, dark: .white)
        statusLabel.shadowColor = .red
        statusLabel.numberOfLines = 0
        statusLabel.font = .systemFont(ofSize: 17, weight: .thin)
        statusLabel.shadowOffset = CGSize(width: 1, height: 1)
        statusLabel.layer.shadowOpacity = 1
        statusLabel.layer.shadowRadius = 30
        statusLabel.clipsToBounds = true
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return statusLabel
    }()
        
    private let statusTextField: CustomTextField = {
        let statusTextField = CustomTextField(placeholder: "header.status".localized, textColor: .createColor(light: .black, dark: .white), font: UIFont.systemFont(ofSize: 15, weight: .regular))
        statusTextField.tintColor = UIColor(named: "#4885CC")
        statusTextField.layer.cornerRadius = 15
        statusTextField.returnKeyType = .done
        return statusTextField
    }()
        
    private let stackViewVertical: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let backViewOne: UIView = {
        let back = UIView()
        back.translatesAutoresizingMaskIntoConstraints = false
        back.layer.cornerRadius = 50/2
        back.clipsToBounds = true
        back.backgroundColor = .black
        back.alpha = 0.5
        return back
    }()
    
    private let backViewSecond: UIView = {
        let back = UIView()
        back.translatesAutoresizingMaskIntoConstraints = false
        back.layer.cornerRadius = 50/2
        back.clipsToBounds = true
        back.backgroundColor = .black
        back.alpha = 0.5
        return back
    }()
    
    private let backViewThree: UIView = {
        let back = UIView()
        back.translatesAutoresizingMaskIntoConstraints = false
        back.layer.cornerRadius = 50/2
        back.clipsToBounds = true
        back.backgroundColor = .black
        back.alpha = 0.5
        return back
    }()
    
    private let stackViewHorizontalButton: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 50
        stackView.layer.cornerRadius = 50/2
        stackView.clipsToBounds = true
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var phoneButton: CustomButton = {
        phoneButton = CustomButton(title: "", titleColor: .white, onTap: { [weak self] in
            self?.callNumber()
        })
        phoneButton.tintColor = .white
        phoneButton.setBackgroundImage(UIImage(systemName: "phone.circle"), for: .normal)
        phoneButton.translatesAutoresizingMaskIntoConstraints = false
        phoneButton.clipsToBounds = true
        return phoneButton
    }()

    
    lazy var messageButton: CustomButton = {
        messageButton = CustomButton(title: "", titleColor: .white, onTap: { [weak self] in
            self?.openMessage()
        })
        messageButton.tintColor = .white
        messageButton.setBackgroundImage(UIImage(systemName: "message.circle"), for: .normal)
        messageButton.translatesAutoresizingMaskIntoConstraints = false
        messageButton.clipsToBounds = true
        return messageButton
    }()
    
    lazy var albumButton: CustomButton = {
        albumButton = CustomButton(title: "", titleColor: .white, onTap: { [weak self] in
            self?.postsCountPressed()
        })
        albumButton.tintColor = .white
        albumButton.setBackgroundImage(UIImage(systemName: "photo.circle"), for: .normal)
        albumButton.translatesAutoresizingMaskIntoConstraints = false
        albumButton.clipsToBounds = true
        return albumButton
    }()
    
    
    private lazy var editButton: CustomButton = {
        editButton = CustomButton(title: "", titleColor: .white, onTap: { [weak self] in
            print("tap editButton")
        })
        editButton.setBackgroundImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        editButton.tintColor = UIColor.createColor(light: .white, dark: .white)
        editButton.backgroundColor = .clear
        editButton.menu = addMenuItems()
        editButton.showsMenuAsPrimaryAction = true
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.clipsToBounds = true
        return editButton
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("header.tap.status".localized, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        return button
    }()
    
    func snp() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)

        //MARK: ОСНОВНАЯ ИНФОРМАЦИЯ
        [avatarImageView,editButton,stackViewVertical].forEach { containerView.addSubview($0) }
        //MARK: Background buttons
        [backViewOne,backViewSecond,backViewThree].forEach { containerView.addSubview($0) }
        //MARK: BUTTONS
        [messageButton,phoneButton,albumButton].forEach { containerView.addSubview($0) }
        //MARK: STACKVERTICAL
        [fullNameLabel, statusLabel].forEach { stackViewVertical.addArrangedSubview($0) }

        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: containerView.widthAnchor),
            centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            heightAnchor.constraint(equalTo: containerView.heightAnchor),
        ])
        //MARK: оступ аватара здесь!        containerView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -15).isActive = true
        containerView.widthAnchor.constraint(equalTo: avatarImageView.widthAnchor).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 620).isActive = true
        
        editButton.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 20).isActive = true
        editButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -20).isActive = true
        editButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        editButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        stackViewVertical.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 10).isActive = true
        stackViewVertical.heightAnchor.constraint(equalToConstant: 100).isActive = true
        stackViewVertical.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        stackViewVertical.bottomAnchor.constraint(equalTo: messageButton.topAnchor,constant: -20).isActive = true
        
        backViewOne.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        backViewOne.heightAnchor.constraint(equalToConstant: 50).isActive = true
        backViewOne.widthAnchor.constraint(equalToConstant: 50).isActive = true
        backViewOne.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -30).isActive = true
        
        backViewSecond.trailingAnchor.constraint(equalTo: phoneButton.leadingAnchor,constant: -50).isActive = true
        backViewSecond.heightAnchor.constraint(equalToConstant: 50).isActive = true
        backViewSecond.widthAnchor.constraint(equalToConstant: 50).isActive = true
        backViewSecond.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -30).isActive = true
        
        backViewThree.leadingAnchor.constraint(equalTo: phoneButton.trailingAnchor,constant: 50).isActive = true
        backViewThree.heightAnchor.constraint(equalToConstant: 50).isActive = true
        backViewThree.widthAnchor.constraint(equalToConstant: 50).isActive = true
        backViewThree.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -30).isActive = true

        phoneButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        phoneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        phoneButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        phoneButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -30).isActive = true
        
        messageButton.trailingAnchor.constraint(equalTo: phoneButton.leadingAnchor,constant: -50).isActive = true
        messageButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        messageButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        messageButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -30).isActive = true
        
        albumButton.leadingAnchor.constraint(equalTo: phoneButton.trailingAnchor,constant: 50).isActive = true
        albumButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        albumButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        albumButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -30).isActive = true
       
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true
        imageViewBottom = avatarImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageViewBottom.isActive = true
        imageViewHeight = avatarImageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        imageViewHeight.isActive = true
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
    
    @objc func openMessage() {
        
    }
    
    @objc func callNumber() {
        
    }
    
    @objc func expandAvatar() {
        self.delegate?.presentMenuAvatar()
    }

    private func buttonPressed() {
        print("Сделать редактирование")
    }
    
    private func postsCountPressed() {
        self.delegate?.postCountsPresent()
    }
    
    private func addMenuItems() -> UIMenu {
        let changeAvatarAction = UIAction(title: "Изменить аватар",image: UIImage(systemName: "person.fill.viewfinder")) { _ in
            self.delegate?.imagePresentPicker()
        }
        let changeName = UIAction(title: "Изменить никнейм",image: UIImage(systemName: "person.text.rectangle.fill")) { _ in
            self.delegate?.changeName()
        }
        
        let changeStatus = UIAction(title: "Изменить статус", image: UIImage(systemName: "heart.text.square.fill")) { _ in
            self.delegate?.changeStatus()
        }
        let menu = UIMenu(title: "Выберите действие", children: [changeAvatarAction, changeName, changeStatus])
        return menu
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        statusTextField.delegate = self
        snp()
        tapScreen()
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
        guard !statusText.isEmpty else {
            AudioServicesPlaySystemSound(self.systemSoundID)
            let bonds = self.statusLabel.bounds
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: .curveLinear) {
                self.statusLabel.bounds = CGRect(x: bonds.origin.x, y: bonds.origin.y, width: bonds.width + 50, height: bonds.height)
            }
            self.statusLabel.text = self.statusTextField.text
            self.statusTextField.text = ""
            
            print("Статус установлен")
            endEditing(true)
            return true
        }
        return true
    }
}

extension ProfileHeaderView {
    public func configure(with user: User) {
        avatarImageView.image = UIImage(named: user.avatar)
        fullNameLabel.text = user.fullName
        statusLabel.text = user.status
        
        if fullNameLabel.text == "ethic91@icloud.com" {
            fullNameLabel.text = "header.name".localized
        }
    }
}
