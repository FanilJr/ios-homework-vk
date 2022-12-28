//
//  SettingsViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 18.09.2022.
//

import UIKit
protocol SettingsDelegate: AnyObject {
    func changeAvatar()
}

class SettingsViewController: UIViewController {
    
    weak var settingDelegate: SettingsDelegate?
    
    let avatarButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("Изменить аватар", for: .normal)
        button.addTarget(self, action: #selector(changeAvatar), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(avatarButton)
        
        NSLayoutConstraint.activate([
            avatarButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            avatarButton.heightAnchor.constraint(equalToConstant: 45),
            avatarButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @objc func changeAvatar() {
        print("change")
        settingDelegate?.changeAvatar()
    }
    
    @objc func cancel() {
        dismiss(animated: true)
    }
}
