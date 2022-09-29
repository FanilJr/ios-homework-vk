//
//  MediaPlayerViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 29.09.2022.
//

import UIKit

final class MediaPlayerViewController: UIViewController {
    
    var album: Album
    
    private lazy var mediaPlayer: MediaPlayer = {
        let player = MediaPlayer(album: album)
        player.translatesAutoresizingMaskIntoConstraints = false
        return player
    }()
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBlurredView()
        setupView()
    }
    
    private func addBlurredView() {
        if !UIAccessibility.isReduceTransparencyEnabled {
            self.view.backgroundColor = UIColor.clear
            
            let bluerEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            let bluerEffectView = UIVisualEffectView(effect: bluerEffect)
            bluerEffectView.frame = self.view.bounds
            bluerEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            
            view.addSubview(bluerEffectView)
        
        } else {
            view.backgroundColor = UIColor.black
        }
    }
    
    private func setupView() {
        view.addSubview(mediaPlayer)
        
        NSLayoutConstraint.activate([
            mediaPlayer.topAnchor.constraint(equalTo: view.topAnchor),
            mediaPlayer.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            mediaPlayer.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            mediaPlayer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mediaPlayer.play()
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        mediaPlayer.stop()
        UIApplication.shared.isIdleTimerDisabled = false
    }
}
