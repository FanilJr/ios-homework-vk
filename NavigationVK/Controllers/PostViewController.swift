//
//  PostViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 21.08.2022.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        let myButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(tapButton))
        
        navigationItem.title = "Пост"
        navigationItem.rightBarButtonItem = myButton

    }
    @objc func tapButton() {
        
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true, completion: nil)
    }
}
