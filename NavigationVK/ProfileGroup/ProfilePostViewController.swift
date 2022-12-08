//
//  ProfilePostViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 19.09.2022.
//

import UIKit

class ProfilePostViewController: UIViewController {
    
    
    let background: UIImageView = {
        let back = UIImageView()
        back.image = UIImage(named: "tekstura")
        back.clipsToBounds = true
        back.translatesAutoresizingMaskIntoConstraints = false
        return back
    }()
    
    lazy var postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var authorName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var comment: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.createColor(light: .black, dark: .white)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = authorName.text
        view.backgroundColor = .white
        layuot()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setupCell(_ model: PostStruct) {
        postImage.image = UIImage(named: model.image)
        authorName.text = model.author
        comment.text = model.description
    }
    
    func layuot() {
        [background, postImage, comment].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            postImage.topAnchor.constraint(equalTo: background.safeAreaLayoutGuide.topAnchor,constant: 20),
            postImage.leadingAnchor.constraint(equalTo: background.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: background.trailingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: 550),
        
            comment.topAnchor.constraint(equalTo: postImage.bottomAnchor,constant: 10),
            comment.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            comment.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
