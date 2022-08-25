//
//  FeedViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 21.08.2022.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {
    
    
    var post = Postik(title: "Мой пост")
    var stackView = UIStackView()
    
    var firstButton: UIButton = {
        let button = UIButton()
        button.setTitle("Первая кнопка", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 14
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    var twoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Вторая кнопка", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 14
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    
    /// Метод перехода на PostViewController
    @objc private func buttonAction() {
        let postViewController = PostViewController()
        postViewController.titlePost = post.title
        
        self.navigationController?.pushViewController(postViewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Лента"
        
        view.backgroundColor = .lightGray
        configureStackView()
    }
    
    func addButtonToStackView() {
        
        stackView.addArrangedSubview(firstButton)
        stackView.addArrangedSubview(twoButton)
    }

    func configureStackView() {
        
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        addButtonToStackView()
        setStackViewConstrains()
    }
    
    func setStackViewConstrains() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
}
