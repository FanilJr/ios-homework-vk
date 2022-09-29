//
//  FeedFlowCoordinator.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 01.09.2022.
//

import Foundation
import UIKit
//import PandoraPlayer

final class FeedFlowCoordinator {
    
    private let controllersFactory: ControllersFactory
    let navCon: UINavigationController
    
    
    init(navCon: UINavigationController, controllersFactory: ControllersFactory) {
        self.controllersFactory = controllersFactory
        self.navCon = navCon
    }
    
    func showPost(title: String) {
        let vc = PostViewController()
        vc.title = title
        navCon.pushViewController(vc, animated: true)
        
        vc.image.image = UIImage(named: "heart5")
    }
    
    func showSecondPost(title: String) {
        let vc = SecondPostViewController()
        vc.title = title
        navCon.pushViewController(vc, animated: true)
        vc.image.image = UIImage(named: "heart4")
        
//        let playerVC = PandoraPlayer.configure(withMPMediaItems: mediaItems)
//        navCon.present(playerVC, animated: true, completion: nil)
    }
    func showPlayer() {
        let vc = PlayerViewController()
        navCon.pushViewController(vc, animated: true)
    }
}
