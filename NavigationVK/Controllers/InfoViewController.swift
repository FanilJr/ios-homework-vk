//
//  InfoViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 21.08.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    let switcherOne: UISwitch = {
        let swit = UISwitch()
        swit.backgroundColor = .black
        swit.layer.cornerRadius = 16
        swit.clipsToBounds = true
        swit.translatesAutoresizingMaskIntoConstraints = false
        return swit
    }()

    let alertButton: CustomButton = {
        let button = CustomButton(title: "Сохранить", titleColor: .white, backgroundColor: .blue, setBackgroundImage: UIImage(named: "blue_pixel") ?? UIImage())
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        alertConstr()
        buttonAlert()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        test()
        
    }
    
    func test() {
        if switcherOne.isOn == true {
            print("switch ON")
        } else {
            print("switch OFF")
        }
    }
    
    func buttonAlert() {
        
        alertButton.tapAction = { [weak self] in
            
            let alert = UIAlertController(title: "Внимание", message: "Редактирование запрещено", preferredStyle: .alert)
            let alertOk = UIAlertAction(title: "OK", style: .default, handler: nil)
            let alertCancel = UIAlertAction(title: "Закрыть", style: .destructive, handler: {_ in
                self?.test()
                print("проверяем алерт")
                self?.dismiss(animated: true)
            })
            [alertOk, alertCancel].forEach { alert.addAction($0) }
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    func alertConstr() {
            
        [switcherOne, alertButton].forEach { view.addSubview($0) }
            
        NSLayoutConstraint.activate([
            switcherOne.topAnchor.constraint(equalTo: view.topAnchor,constant: 20),
            switcherOne.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            
            alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertButton.widthAnchor.constraint(equalToConstant: 120),
            alertButton.heightAnchor.constraint(equalToConstant: 50),
            alertButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -20)
        ])
    }
}

