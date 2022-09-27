//
//  VoiceRecView.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 22.09.2022.
//

import Foundation
import UIKit
 
 protocol VoiceRecViewDelegate: AnyObject {
     func didTapPlayButton()
     func sliderAction()
 }
 
 final class VoiceRecView: UIView {
 
     weak var delegate: VoiceRecViewDelegate?
 
     let playButton = CustomButton(title: "", titleColor: .white, backgroundColor: .clear, setBackgroundImage: UIImage(named: "") ?? UIImage())
     let nextButton = CustomButton(title: "", titleColor: .white, backgroundColor: .clear, setBackgroundImage: UIImage(named: "next") ?? UIImage())
     let backButton = CustomButton(title: "", titleColor: .white, backgroundColor: .clear, setBackgroundImage: UIImage(named: "back") ?? UIImage())
     
     private var nameArtist: UILabel = {
         let name = UILabel()
         name.translatesAutoresizingMaskIntoConstraints = false
         name.textColor = .black
         name.text = "Saint JHN"
         name.font = UIFont.systemFont(ofSize: 45, weight: .semibold)
         name.font = UIFont(name: "Bodoni 72", size: 45)
         return name
     }()
     private var nameAlbum: UILabel = {
         let name = UILabel()
         name.textColor = .black
         name.text = "Ghetto Lenny's Love Songs"
         name.font = UIFont.systemFont(ofSize: 27, weight: .bold)
         name.font = UIFont(name: "Bodoni 72", size: 27)
         name.translatesAutoresizingMaskIntoConstraints = false
         return name
     }()
     
     private var line: UIView = {
         let line = UIView()
         line.translatesAutoresizingMaskIntoConstraints = false
         line.backgroundColor = .black
         line.layer.cornerRadius = 2
         line.clipsToBounds = true
         return line
         
     }()
 
     private var background: UIImageView = {
         let background = UIImageView()
         background.image = UIImage(named: "background2")
         background.contentMode = .scaleAspectFill
         background.translatesAutoresizingMaskIntoConstraints = false
         return background
     }()
 
     let slider: UISlider = {
         let slider = UISlider()
         slider.minimumValue = 0.0
         slider.maximumValue = 1000
         slider.addTarget(self, action: #selector(changeAudiTime), for: .touchDragInside)
         slider.thumbTintColor = .systemMint
         slider.setMinimumTrackImage(UIImage(named: "slider-track-fill"), for: UIControl.State())
         slider.setMaximumTrackImage(UIImage(named: "slider-track"), for: UIControl.State())
         slider.setThumbImage(UIImage(named: "thumb"), for: UIControl.State())
         slider.tintColor = .green
         slider.translatesAutoresizingMaskIntoConstraints = false
         return slider
     }()
 
     private let trackNameLabel: UILabel = {
         let label = UILabel()
         label.text = "Trophies 🎸"
         label.textColor = .black
         label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
         label.font = UIFont(name: "Bodoni 72", size: 22)
         
//         label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
 
     private let imageTrack: UIImageView = {
         let image = UIImageView()
         image.layer.borderWidth = 2
         image.layer.borderColor = UIColor.purple.cgColor
         image.layer.cornerRadius = 120
         image.clipsToBounds = true
         image.image = UIImage(named: "Trophies")
         image.translatesAutoresizingMaskIntoConstraints = false
         return image
     }()
 
     private let buttonHorizontalStackView: UIStackView = {
 
         let stackView = UIStackView()
         stackView.translatesAutoresizingMaskIntoConstraints = false
         stackView.axis = .horizontal
         stackView.distribution = .fillEqually
         stackView.spacing = 20
         return stackView
     }()
 
 // MARK: - Initialiser
     init(delegate: VoiceRecViewDelegate?) {
         super.init(frame: CGRect.zero)
         self.delegate = delegate
         backgroundColor = .white
         layout()
         taps()
     }
 
     required init?(coder aDecoder: NSCoder)
     {
         fatalError("init(coder:) has not been implemented")
     }
 
 // MARK: - Metods

     private func taps() {
         playButton.tapAction = { [weak self] in
             self?.delegate?.didTapPlayButton()
         }
     }
 
     func setTitlePlayButton(_ title: String) {
         playButton.setTitle(title, for: .normal)
     }
     
     func setImagePlayButton(_ image: UIImage) {
         playButton.setImage(image, for: .normal)
     }
 
     @objc func changeAudiTime() {
         self.delegate?.sliderAction()
         print(Double(slider.value))
     }
 
     private func layout() {
         [backButton, playButton, nextButton].forEach { buttonHorizontalStackView.addArrangedSubview($0) }
         [background, nameArtist, line, imageTrack, nameAlbum, slider, trackNameLabel, buttonHorizontalStackView].forEach { addSubview($0) }
 
         NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            nameArtist.topAnchor.constraint(equalTo: background.safeAreaLayoutGuide.topAnchor,constant: 120),
            nameArtist.leadingAnchor.constraint(equalTo: background.leadingAnchor,constant: 32),
            
            line.topAnchor.constraint(equalTo: nameArtist.bottomAnchor),
            line.leadingAnchor.constraint(equalTo: background.leadingAnchor,constant: 32),
            line.trailingAnchor.constraint(equalTo: background.trailingAnchor,constant: -5),
            line.heightAnchor.constraint(equalToConstant: 3),
 
//            imageTrack.topAnchor.constraint(equalTo: line.bottomAnchor,constant: 30),
            imageTrack.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            imageTrack.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            imageTrack.widthAnchor.constraint(equalToConstant: 240),
            imageTrack.heightAnchor.constraint(equalToConstant: 240),
            
            nameAlbum.topAnchor.constraint(equalTo: imageTrack.bottomAnchor,constant: 30),
            nameAlbum.leadingAnchor.constraint(equalTo: background.leadingAnchor,constant: 32),
 
            trackNameLabel.topAnchor.constraint(equalTo: nameAlbum.bottomAnchor),
            trackNameLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor,constant: 32),
 
            slider.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor,constant: 20),
            slider.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            slider.widthAnchor.constraint(equalToConstant: 250),
            
            buttonHorizontalStackView.topAnchor.constraint(equalTo: slider.bottomAnchor,constant: 30),
            buttonHorizontalStackView.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            buttonHorizontalStackView.widthAnchor.constraint(equalToConstant: 250),
            buttonHorizontalStackView.heightAnchor.constraint(equalToConstant: 70),
         ])
     }
 }
