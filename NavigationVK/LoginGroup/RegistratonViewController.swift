//
//  RegistratonViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 15.10.2022.
//

import UIKit

class RegistratonViewController: UIViewController {
    
    private lazy var registrationView = RegistrationView(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
    }
    
    func layout() {
        [registrationView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            registrationView.topAnchor.constraint(equalTo: view.topAnchor),
            registrationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registrationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            registrationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension RegistratonViewController: RegistrationViewDelegate {
    func didTapRegistrationButton() {
        dismiss(animated: true)
    }
    
    
}
