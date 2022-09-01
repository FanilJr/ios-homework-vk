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
        backgroundColor = .gray
        layout()
        taps()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Metods
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
        [stackView, textField, resultLabel, notificationButton].forEach { scrollView.addSubview($0) }
        
        [postButtonFirst, postButtonSecond].forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 105),
            
            textField.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 20),
            textField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 16),
            textField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 30),

            resultLabel.topAnchor.constraint(equalTo: textField.bottomAnchor,constant: 10),
            resultLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 16),
            resultLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -16),
            resultLabel.heightAnchor.constraint(equalToConstant: 30),

            notificationButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor,constant: 10),
            notificationButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 16),
            notificationButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -16),
            notificationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
