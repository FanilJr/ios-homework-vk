//
//  PostViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 21.08.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        let myButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(tapButton))
        
        navigationItem.title = "Пост"
        navigationItem.rightBarButtonItem = myButton
        layuot()

    }
   
    
    @objc func tapButton() {
        
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true, completion: nil)
    }
    
    func layuot() {
        
        view.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            image.heightAnchor.constraint(equalToConstant: 300),
            image.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
}
