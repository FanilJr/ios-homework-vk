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

    init(title: String, titleColor: UIColor, backgroundColor: UIColor, setBackgroundImage: UIImage) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setButton(title: title, titleColor: titleColor, backgroundColor: backgroundColor, setBackgroundImage: setBackgroundImage)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setButton(title: String, titleColor: UIColor,  backgroundColor: UIColor, setBackgroundImage: UIImage) {
        
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        layer.cornerRadius = 10
        self.setBackgroundImage(setBackgroundImage, for: .normal)
        self.backgroundColor = backgroundColor
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        
        switch state {
                case .normal:
                    alpha = 1
                case .selected:
                    alpha = 0.8
                case .highlighted:
                    alpha = 0.8
                case .disabled:
                    alpha = 0.8
                default:
                    alpha = 1
        }
    }

    @objc private func buttonTapped() {
        tapAction?()
    }
}
