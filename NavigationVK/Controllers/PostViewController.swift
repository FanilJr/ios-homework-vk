//
//  PostViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 21.08.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    var titlePost: String = "Пост"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Создание кнопки на Navigation Bar - edit
        let myButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(tapButton))
        
        navigationItem.title = titlePost
        navigationItem.rightBarButtonItem = myButton

    }
    /// Метод вызова InfoViewController
    @objc func tapButton() {
        
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true, completion: nil)
        
    }
}
