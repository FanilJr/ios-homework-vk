//
//  FeedView.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 29.08.2022.
//

import UIKit

protocol FeedViewDelegate: AnyObject {
    func didTapPostButton()
    func check(word: String)
    func didTapSecondPostButton()
}

final class FeedView: UIView {
    
    weak var delegate: FeedViewDelegate?
    private let nc = NotificationCenter.default
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    let firstPost: UIImageView = {
        let post = UIImageView()
        post.image = UIImage(named: "heart2")
        post.layer.cornerRadius = 10
        post.layer.borderWidth = 1
        post.clipsToBounds = true
        post.layer.borderColor = UIColor.gray.cgColor
        post.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        post.translatesAutoresizingMaskIntoConstraints = false
        return post
    }()
    
    private let secondPost: UIImageView = {
        let post = UIImageView()
        post.image = UIImage(named: "heart4")
        post.contentMode = .scaleAspectFill
        post.layer.cornerRadius = 10
        post.layer.borderWidth = 1
        post.clipsToBounds = true
        post.layer.borderColor = UIColor.gray.cgColor
        post.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        post.translatesAutoresizingMaskIntoConstraints = false
        return post
    }()
    
    private let postButtonFirst: CustomButton = {
        let button = CustomButton(title: "Перейти на пост First Heart", titleColor: .white, backgroundColor: .blue, setBackgroundImage: UIImage(named: "blue_pixel") ?? UIImage())
            button.layer.cornerRadius = 10
            button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return button
    }()
    
    private let postButtonSecond: CustomButton = {
        let button = CustomButton(title: "Перейти на пост Second Heart", titleColor: .white, backgroundColor: .blue, setBackgroundImage: UIImage(named: "blue_pixel") ?? UIImage())
            button.layer.cornerRadius = 10
            button.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return button
    }()
    
    private let notificationButton: CustomButton = {
        let button = CustomButton(title: "Кнопка проверки", titleColor: .white, backgroundColor: .blue, setBackgroundImage: UIImage(named: "blue_pixel") ?? UIImage())
        return button
    }()
    
    
    private let textField: CustomTextField = {
        let textfield = CustomTextField(placeholder: "пароль: junior", textColor: .black, font: UIFont.systemFont(ofSize: 20))
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    init(delegate: FeedViewDelegate?) {
        super.init(frame: CGRect.zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        self.delegate = delegate
        backgroundColor = .clear
        addObserver()
        tapScreen()
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
        postButtonFirst.tapAction = { [weak self] in
            self?.delegate?.didTapPostButton()
        }
            
        postButtonSecond.tapAction = { [weak self] in
            self?.delegate?.didTapSecondPostButton()
        }
        notificationButton.tapAction = { [weak self] in
            self?.delegate?.check(word: self?.textField.text ?? "")
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 2, initialSpringVelocity: 1, options: .curveLinear) {
                self?.notificationButton.bounds = CGRect(x: (self!.bounds.origin.x) - 30, y: (self!.bounds.origin.y), width: self!.bounds.width + 30, height: self!.bounds.height + 10)
                self?.notificationButton.titleLabel?.bounds = CGRect(x: self!.bounds.origin.x, y: self!.bounds.origin.y, width: self!.bounds.width + 100, height: self!.bounds.height)
            }
        }
    }
    
    func setResultLabel(result: Bool) {
        
        if result {
            resultLabel.text = "Верно"
            resultLabel.textColor = .systemGreen
        } else {
            resultLabel.text = "Не верно"
            resultLabel.textColor = .systemRed
        }
    }
    
    private func layout() {
        
        [textField, resultLabel, notificationButton].forEach { stackView.addArrangedSubview($0) }
        [firstPost, postButtonFirst, secondPost, postButtonSecond, stackView].forEach { contentView.addSubview($0) }
        scrollView.addSubview(contentView)
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            firstPost.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,constant: 32),
            firstPost.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 32),
            firstPost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -32),
            firstPost.heightAnchor.constraint(equalToConstant: 300),
            
            postButtonFirst.topAnchor.constraint(equalTo: firstPost.bottomAnchor),
            postButtonFirst.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 32),
            postButtonFirst.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -32),
            postButtonFirst.heightAnchor.constraint(equalToConstant: 50),
            
            secondPost.topAnchor.constraint(equalTo: postButtonFirst.bottomAnchor,constant: 32),
            secondPost.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 32),
            secondPost.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -32),
            secondPost.heightAnchor.constraint(equalToConstant: 300),
            
            postButtonSecond.topAnchor.constraint(equalTo: secondPost.bottomAnchor),
            postButtonSecond.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 32),
            postButtonSecond.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -32),
            postButtonSecond.heightAnchor.constraint(equalToConstant: 50),
            
            stackView.topAnchor.constraint(equalTo: postButtonSecond.bottomAnchor,constant: 32),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 32),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -32),
            stackView.heightAnchor.constraint(equalToConstant: 150),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -32)
            
        ])
    }
}

extension FeedView {
    
    func tapScreen() {
        let recognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        recognizer.cancelsTouchesInView = false
        addGestureRecognizer(recognizer)
    }

    @objc func dismissKeyboard() {
        endEditing(true)
    }
}
