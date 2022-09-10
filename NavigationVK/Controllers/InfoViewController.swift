//
//  InfoViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 21.08.2022.
//

import UIKit

class InfoViewController: UIViewController {

    let alertButton: CustomButton = {
        let button = CustomButton(title: "Перейти на алерт", titleColor: .white, backgroundColor: .blue, setBackgroundImage: UIImage(named: "blue_pixel") ?? UIImage())
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        alertConstr()
        buttonAlert()
    }
    
    func buttonAlert() {
        
        alertButton.tapAction = { [weak self] in
            
            let alert = UIAlertController(title: "Внимание", message: "Редактирование запрещено", preferredStyle: .alert)
            let alertOk = UIAlertAction(title: "OK", style: .default, handler: nil)
            let alertCancel = UIAlertAction(title: "Закрыть", style: .destructive, handler: {_ in
                print("проверяем алерт")
                self?.dismiss(animated: true)
            })
            [alertOk, alertCancel].forEach { alert.addAction($0) }
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func alertConstr() {
            
        view.addSubview(alertButton)
            
        NSLayoutConstraint.activate([
            alertButton.widthAnchor.constraint(equalToConstant: 200),
            alertButton.heightAnchor.constraint(equalToConstant: 50),
            alertButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            alertButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}

