//
//  VoiceRecorderViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 22.09.2022.
//
import UIKit
import AVKit
import AVFoundation
 
 class VoiceRecorderViewController: UIViewController {
 
     var player: AVAudioPlayer?
     lazy var voiceRecView = VoiceRecView(delegate: self)
     lazy var slider = voiceRecView.slider
     let recordedFileUrl = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Trophies", ofType: "mp3")!)
 
     init() {
         super.init(nibName: nil, bundle: nil)
     }
 
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
 
     override func viewDidLoad() {
         super.viewDidLoad()
         layout()
         DispatchQueue.main.asyncAfter(deadline: .now()) {
             self.slider.maximumValue = Float(self.player?.duration ?? 0.0)
             self.slider.value = Float(self.player?.currentTime ?? 0.0)
         }
     }
 
     override func viewWillAppear(_ animated: Bool) {
 
         tabBarController?.tabBar.isHidden = true
         navigationController?.navigationBar.isHidden = true
         voiceRecView.playButton.setImage(UIImage(named: "play"), for: .normal)
         
     }
 
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
     }
 
     override func viewDidAppear(_ animated: Bool) {
     }
 
     private func layout() {
         view.addSubview(voiceRecView)
         voiceRecView.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
            voiceRecView.topAnchor.constraint(equalTo: view.topAnchor),
            voiceRecView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            voiceRecView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            voiceRecView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
         ])
     }
}

extension VoiceRecorderViewController: VoiceRecViewDelegate {
 
        func sliderAction() {
            slider.maximumValue = Float(player?.duration ?? 0.0)
            player?.currentTime = TimeInterval(slider.value)
        }
 
        func didTapPlayButton() {
            let isPlayng = player?.isPlaying ?? false
            if let _ = player, isPlayng {
                playerStop()
                voiceRecView.playButton.setImage(UIImage(named: "play"), for: .normal)
            } else {
                
                playerPlay()
                voiceRecView.playButton.setImage(UIImage(named: "pause"), for: .normal)

            }
        }
    }
 
 extension VoiceRecorderViewController: AVAudioPlayerDelegate {
     func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
         playerStop()
     }
 
     private func prepareToPlay() {
         do {
             player = try AVAudioPlayer(contentsOf: recordedFileUrl)
             player!.delegate = self
             player!.prepareToPlay()
             Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                 self.slider.value = Float(self.player?.currentTime ?? 0.0)
             }
             print("Длительность записи \(player!.duration)")
         }
         catch {
             print(error)
         }
     }
 
     private func playerStop() {
         player?.pause()
         player = nil
         voiceRecView.setTitlePlayButton("Play")
         voiceRecView.playButton.setImage(UIImage(named: "play"), for: .normal)
     }
 
     private func playerPlay() {
         prepareToPlay()
         player!.play()
         DispatchQueue.main.asyncAfter(deadline: .now()) {
             self.slider.value = Float(self.player?.currentTime ?? 0.0)
         }
         slider.maximumValue = Float(player?.duration ?? 0.0)
         voiceRecView.setTitlePlayButton("Stop")
         
         voiceRecView.setImagePlayButton(UIImage(named: "pause") ?? UIImage())
         voiceRecView.playButton.setImage(UIImage(named: "pause"), for: .normal)

     }
 }
 
