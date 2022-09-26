//
//  VoiceRecView.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 22.09.2022.
//

/*import Foundation
 import UIKit
 
 protocol VoiceRecViewDelegate: AnyObject {
 func didTapPlayButton()
 func didTapRecButton()
 func sliderAction()
 }
 
 final class VoiceRecView: UIView {
 
 // MARK: - Properties
 weak var delegate: VoiceRecViewDelegate?
 
 private let playButton = CustomButton(title: "Play", titleColor: .white, backgroundColor: .clear, setBackgroundImage: UIImage(named: "buttonPlayer") ?? UIImage())
 private let recButton = CustomButton(title: "Record", titleColor: .white, backgroundColor: .clear, setBackgroundImage: UIImage(named: "buttonPlayer") ?? UIImage())
 
 private var background: UIImageView = {
 let background = UIImageView()
 background.image = UIImage(named: "vk1776")
 background.contentMode = .scaleAspectFill
 background.translatesAutoresizingMaskIntoConstraints = false
 return background
 }()
 
 let slider: UISlider = {
 let slider = UISlider()
 slider.addTarget(self, action: #selector(changeAudiTime), for: .touchDragInside)
 slider.thumbTintColor = .systemPink
 slider.tintColor = .green
 slider.translatesAutoresizingMaskIntoConstraints = false
 return slider
 }()
 
 private let trackNameLabel: UILabel = {
 let label = UILabel()
 label.text = "Saint JHN - Trophies🎸"
 label.textColor = .white
 label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
 label.translatesAutoresizingMaskIntoConstraints = false
 return label
 }()
 
 private let imageTrack: UIImageView = {
 let image = UIImageView()
 image.layer.borderWidth = 2
 image.layer.borderColor = UIColor.purple.cgColor
 image.layer.cornerRadius = 30
 image.clipsToBounds = true
 image.image = UIImage(named: "SaintJHN")
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
 recButton.tapAction = { [weak self] in
 self?.delegate?.didTapRecButton()
 }
 }
 
 func setTitleRecButton(_ title: String) {
 recButton.setTitle(title, for: .normal)
 }
 
 func setTitlePlayButton(_ title: String) {
 playButton.setTitle(title, for: .normal)
 }
 
 @objc func changeAudiTime() {
 self.delegate?.sliderAction()
 print(Double(slider.value))
 }
 
 private func layout() {
 [playButton, recButton].forEach { buttonHorizontalStackView.addArrangedSubview($0) }
 [background, imageTrack, slider, trackNameLabel, buttonHorizontalStackView].forEach { addSubview($0) }
 
 NSLayoutConstraint.activate([
 background.topAnchor.constraint(equalTo: topAnchor),
 background.leadingAnchor.constraint(equalTo: leadingAnchor),
 background.trailingAnchor.constraint(equalTo: trailingAnchor),
 background.bottomAnchor.constraint(equalTo: bottomAnchor),
 
 imageTrack.topAnchor.constraint(equalTo: background.safeAreaLayoutGuide.topAnchor,constant: 50),
 imageTrack.leadingAnchor.constraint(equalTo: background.leadingAnchor,constant: 20),
 imageTrack.heightAnchor.constraint(equalToConstant: 400),
 imageTrack.trailingAnchor.constraint(equalTo: background.trailingAnchor,constant: -20),
 
 trackNameLabel.topAnchor.constraint(equalTo: imageTrack.bottomAnchor,constant: 40),
 trackNameLabel.centerXAnchor.constraint(equalTo: background.centerXAnchor),
 
 slider.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor,constant: 20),
 slider.leadingAnchor.constraint(equalTo: background.leadingAnchor,constant: 10),
 slider.trailingAnchor.constraint(equalTo: background.trailingAnchor,constant: -10),
 
 //            buttonHorizontalStackView.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor,constant: 120),
 buttonHorizontalStackView.centerXAnchor.constraint(equalTo: background.centerXAnchor),
 buttonHorizontalStackView.leadingAnchor.constraint(equalTo: background.leadingAnchor,constant: 20),
 buttonHorizontalStackView.trailingAnchor.constraint(equalTo: background.trailingAnchor,constant: -20),
 buttonHorizontalStackView.heightAnchor.constraint(equalToConstant: 60),
 buttonHorizontalStackView.bottomAnchor.constraint(equalTo: background.bottomAnchor,constant: -50)
 ])
 }
 }
 */
