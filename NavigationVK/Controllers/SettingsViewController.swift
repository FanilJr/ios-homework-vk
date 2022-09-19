//
//  SettingsViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 18.09.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(create))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancel))
        navigationController?.navigationBar.tintColor = UIColor(named: "Purple")
        navigationController?.navigationBar.scrollEdgeAppearance = UINavigationBarAppearance()
        
    }
    @objc func create() {
        print("save")
    }
    
    @objc func cancel() {
        dismiss(animated: true)
    }
}
