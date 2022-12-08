//
//  MainTabBarController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 05.09.2022.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blureEffect = UIBlurEffect(style: .light)
        
        let bluerView = UIVisualEffectView(effect: blureEffect)
        bluerView.frame = tabBar.bounds
        bluerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBar.insertSubview(bluerView, at: 0)
    }
}
