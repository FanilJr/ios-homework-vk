//
//  SecondPostViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 09.09.2022.
//

import UIKit

class SecondPostViewController: UIViewController {
    
    var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let scrollView: UIScrollView = {
        
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = .clear
        return scroll
        
    }()
    
    let contentView: UIView = {
        
        let content = UIView()
        content.backgroundColor = .clear
        content.translatesAutoresizingMaskIntoConstraints = false
        return content
        
    }()
    
    let labelView: UILabel = {
        
        let label = UILabel()
        label.text = "Притча об оскорблениях:"
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let infoLabel: UILabel = {
        
        let label = UILabel()
        label.text = #"""
        На востоке жил мудрец, который так учил своих учеников: 'Люди оскорбляют тремя способами: ои могут сказать что ты глуп, могут назвать тебя рабом, могут назвать тебя бездарным. Если такое случилось с вами вспомните простую истину: только дурак назовет дураком другого, только раб ищет раба в другом, только бездарь чужим безумием оправдает то, что не понимает сам. \#n
        Мораль: чем ниже интеллект, тем громче оскорбления!
        """#
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let myButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(tapButton))
        navigationItem.title = "Притча об оскорблениях"
        navigationItem.rightBarButtonItem = myButton
        setup()

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

    }
    
    @objc func tapButton() {
    
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true, completion: nil)
    }

    func setup() {
        
        [image, labelView, infoLabel].forEach { contentView.addSubview($0) }
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            image.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 22),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 100),
            image.heightAnchor.constraint(equalToConstant: 100),
            
            labelView.topAnchor.constraint(equalTo: image.bottomAnchor,constant: 22),
            labelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            infoLabel.topAnchor.constraint(equalTo: labelView.bottomAnchor,constant: 16),
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
