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

    init(title: String = "", titleColor: UIColor = .black, backgroundColor: UIColor = .white) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setButton(title: title, titleColor: titleColor, backgroundColor: backgroundColor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setButton(title: String, titleColor: UIColor,  backgroundColor: UIColor) {
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
    }

    @objc private func buttonTapped() {
        tapAction?()
    }

}
