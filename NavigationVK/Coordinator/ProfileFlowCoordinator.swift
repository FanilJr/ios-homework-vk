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
}
