//
//  AlertController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 01.09.2022.
//

import Foundation
import UIKit

final class AlertController: UIAlertController {
    
    func presentAlert() {
        lazy var alert = UIAlertController(title: "Введите логин и пароль", message: #"""
   #логин: Fanil_Jr \#n #пароль: Netology
   """#, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alert, animated: true)
    }
}
