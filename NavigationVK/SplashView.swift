//
//  SplashViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 03.09.2022.
//

import UIKit

final class SplashView: UIView {
    
    let background: UIImageView = {
        
        let background = UIImageView()
        background.image = UIImage(named: "background3")
        background.contentMode = .scaleAspectFill
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
        
    }()
    
    let vkLogo: UIImageView = {
        
        let image = UIImageView()
        image.image = UIImage(named: "vk")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false

        layout()
        animated()
        dismissed()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")

    }
    
    func layout() {
        
        [background, vkLogo].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
        
            vkLogo.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            vkLogo.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            vkLogo.widthAnchor.constraint(equalToConstant: 100),
            vkLogo.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func animated() {
        UIView.animate(withDuration: 1.2) {
            self.vkLogo.transform = CGAffineTransform(scaleX: 100 / 30, y: 100 / 30)
        }
    }
    func dismissed() {
        UIView.animate(withDuration: 1.2, animations: {
            self.alpha = 0.0
        })
        
    }
}
