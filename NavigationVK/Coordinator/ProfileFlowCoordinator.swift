//
//  ProfileFlowCoordinator.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 01.09.2022.
//

import Foundation
import UIKit

final class ProfileFlowCoordinator {
    
    private let controllersFactory: ControllersFactory
    let navCon: UINavigationController
    
    init(navCon: UINavigationController, controllersFactory: ControllersFactory) {
        self.controllersFactory = controllersFactory
        self.navCon = navCon
    }
    
    func showProfile(userName: String) {
        let profileVC = controllersFactory.makeProfileViewController(userName: userName, coordinator: self)
        navCon.pushViewController(profileVC, animated: true)
    }
    
    func showPhotos() {
        let vc = PhotosViewController()
        navCon.pushViewController(vc, animated: true)
    }
    
    func showSettings(title: String) {
        let vc = UINavigationController(rootViewController: SettingsViewController())
        vc.title = title
        vc.modalPresentationStyle = .fullScreen
        navCon.present(vc, animated: true, completion: nil)
    }
    
    func showProfilePost() {
        let vc = ProfilePostViewController()
        navCon.pushViewController(vc, animated: true)
    }
    
    func showAlert(title: String, message: String, buttonText: String = "Ok") {
        // создаём объекты всплывающего окна
        let alert = UIAlertController(
            title: title, // заголовок всплывающего окна
            message: message, // текст во всплывающем окне
            preferredStyle: .alert) // preferredStyle может быть .alert или .actionSheet

        // создаём для него кнопки с действиями
        let action = UIAlertAction(title: buttonText, style: .default)

        // добавляем в алерт кнопки
        alert.addAction(action)

        // показываем всплывающее окно
        navCon.present(alert, animated: true, completion: nil)
    }

    func pop() {
        navCon.popViewController(animated: true)
    }
}
