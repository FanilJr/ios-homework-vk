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
}

final class FeedView: UIView {
    
    weak var delegate: FeedViewDelegate?
    
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
    
    
    private let postButtonFirst: CustomButton = {
        
        let button = CustomButton()
        button.setTitle("Первая кнопка", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let postButtonSecond: CustomButton = {
        
        let button = CustomButton()
        button.setTitle("Вторая кнопка", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let notificationButton: CustomButton = {
        
        let button = CustomButton()
        button.setTitle("Кнопка проверки", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    private let textField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "пароль: junior"
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
        self.delegate = delegate
        backgroundColor = .systemGray6
        layout()
        taps()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    private func taps() {
        postButtonFirst.tapAction = { [weak self] in
            self?.delegate?.didTapPostButton()
        }
        postButtonSecond.tapAction = { [weak self] in
            self?.delegate?.didTapPostButton()
        }
        notificationButton.tapAction = { [weak self] in
            self?.delegate?.check(word: self?.textField.text ?? "")
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
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        [postButtonFirst, postButtonSecond, textField, resultLabel, notificationButton].forEach { stackView.addArrangedSubview($0) }
//        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
}
