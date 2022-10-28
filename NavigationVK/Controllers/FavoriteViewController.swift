//
//  FavoriteViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 27.10.2022.
//

import UIKit

class FavoriteViewController: UIViewController {

    let background: UIImageView = {
        let back = UIImageView()
        back.image = UIImage(named: "tekstura")
        back.translatesAutoresizingMaskIntoConstraints = false
        return back
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Избранное"
        
        layout()
    }
    
    private func layout() {
        view.addSubview(background)
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
