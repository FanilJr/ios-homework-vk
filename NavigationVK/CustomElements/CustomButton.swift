//
//  CustomButton.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 23.08.2022.
//

import Foundation
import UIKit

final class CustomButton: UIButton {

    var tapAction: (() -> Void)?

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setButton() {
    
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
    }

    @objc private func buttonTapped() {
        tapAction?()
    }

}
