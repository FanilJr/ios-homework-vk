//
//  MediaPlayer.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 27.09.2022.
//

import Foundation
import UIKit
import AVKit

final class MediaPlayer: UIView {

    var album: Album

    private lazy var albumName: UILabel = {
        let album = UILabel()
        album.translatesAutoresizingMaskIntoConstraints = false
        album.textColor = .systemPink
        album.textAlignment = .center
        album.font = .systemFont(ofSize: 25, weight: .bold)
        return album
    }()

    private lazy var albumCover: UIImageView = {
        let cover = UIImageView()
        cover.translatesAutoresizingMaskIntoConstraints = false
        cover.contentMode = .scaleAspectFill
        cover.clipsToBounds = true
        cover.layer.cornerRadius = 30
        return cover
    }()

    private lazy var progressBar: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(progressScrubbed(_:)), for: .valueChanged)
        return slider
    }()
    
    private lazy var elapsedTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.text = "00:00"
        return label
    }()

    
    private lazy var remainingTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.text = "00:00"
        return label
    }()
    
    private lazy var songNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemPink
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private lazy var previousButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        button.setImage(UIImage(systemName: "backward.end.fill", withConfiguration: config), for: .normal)
        button.addTarget(self, action: #selector(didTapPrevious(_:)), for: .touchUpInside)
        button.tintColor = .systemPink
        return button
    }()
    
    private lazy var playPauseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 70)
        button.setImage(UIImage(systemName: "play.circle.fill", withConfiguration: config), for: .normal)
        button.addTarget(self, action: #selector(didTapPlayPause(_:)), for: .touchUpInside)
        button.tintColor = .systemPink
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        button.setImage(UIImage(systemName: "forward.end.fill", withConfiguration: config), for: .normal)
        button.tintColor = .systemPink
        button.addTarget(self, action: #selector(didTapNext(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var controlStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [previousButton, playPauseButton, nextButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 20
        return stack
    }()
    
    private var player = AVAudioPlayer()
    private var timer: Timer?
    private var playingIndex = 0
    
    init(album: Album) {
        self.album = album
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {

        albumName.text = album.name
        albumCover.image = UIImage(named: album.image)
        setupPlayer(song: album.songs[playingIndex])
        
        [albumName,songNameLabel,artistLabel,elapsedTimeLabel,remainingTimeLabel].forEach { (all) in
            all.textColor = .white }
        
        [albumName,albumCover,songNameLabel,artistLabel,progressBar,elapsedTimeLabel,remainingTimeLabel,controlStack].forEach { addSubview($0) }
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            albumName.topAnchor.constraint(equalTo: topAnchor,constant: 16),
            albumName.leadingAnchor.constraint(equalTo: leadingAnchor),
            albumName.trailingAnchor.constraint(equalTo: trailingAnchor),
        
            albumCover.topAnchor.constraint(equalTo: albumName.bottomAnchor,constant: 32),
            albumCover.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            albumCover.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            albumCover.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.5),
            
            songNameLabel.topAnchor.constraint(equalTo: albumCover.bottomAnchor,constant: 16),
            songNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            songNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            
            artistLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor,constant: 8),
            artistLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            artistLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            
            progressBar.topAnchor.constraint(equalTo: artistLabel.bottomAnchor,constant: 8),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            
            elapsedTimeLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor,constant: 8),
            elapsedTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            
            remainingTimeLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor,constant: 8),
            remainingTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            
            controlStack.topAnchor.constraint(equalTo: remainingTimeLabel.bottomAnchor,constant: 8),
            controlStack.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 32),
            controlStack.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -32)
        ])
    }
    
    private func setupPlayer(song: Song) {
        guard let url = Bundle.main.url(forResource: song.fileName, withExtension: "mp3") else {
            return
        }
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        }
        
        songNameLabel.text = song.name
        artistLabel.text = song.artist
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player.delegate = self
            player.prepareToPlay()
            
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func play() {
        progressBar.value = 0.0
        progressBar.maximumValue = Float(player.duration)
        player.play()
        setPlayPauseIcon(isPlaying: player.isPlaying)
    }
    
    func stop() {
        player.stop()
        timer?.invalidate()
        timer = nil
    }
    
    private func setPlayPauseIcon(isPlaying: Bool) {
        let config = UIImage.SymbolConfiguration(pointSize: 70)
        playPauseButton.setImage(UIImage(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill",withConfiguration: config), for: .normal)
        playPauseButton.tintColor = .systemPink
    }
    
   @objc private func updateProgress() {
       progressBar.value = Float(player.currentTime)
       
       elapsedTimeLabel.text = getFormattedTime(timeInterval: player.currentTime)
       let remainingTime = player.duration - player.currentTime
       remainingTimeLabel.text = getFormattedTime(timeInterval: remainingTime)
    }


    @objc func progressScrubbed(_ sender: UISlider) {
        player.currentTime = Float64(sender.value)

    }
    
    @objc func didTapPrevious(_ sender: UIButton) {
        playingIndex -= 1
        if playingIndex < 0 {
            playingIndex = album.songs.count - 1
        }
        setupPlayer(song: album.songs[playingIndex])
        play()
        setPlayPauseIcon(isPlaying: player.isPlaying)
    }
    
    @objc func didTapPlayPause(_ sender: UIButton) {
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
        
        setPlayPauseIcon(isPlaying: player.isPlaying)
    }
    
    @objc func didTapNext(_ sender: UIButton) {
        playingIndex += 1
        if playingIndex >= album.songs.count {
            playingIndex = 0
        }
        setupPlayer(song: album.songs[playingIndex])
        play()
        setPlayPauseIcon(isPlaying: player.isPlaying)
    }
    
    private func getFormattedTime(timeInterval: TimeInterval) -> String {
        let mins = timeInterval / 60
        let secs = timeInterval.truncatingRemainder(dividingBy: 60)
        let timeFormatter = NumberFormatter()
        timeFormatter.minimumIntegerDigits = 2
        timeFormatter.minimumFractionDigits = 0
        timeFormatter.roundingMode = .down
        
        guard let minsString = timeFormatter.string(from: NSNumber(value: mins)), let secStr = timeFormatter.string(from: NSNumber(value: secs)) else {
            return "00:00"
        }
        
        return "\(minsString):\(secStr)"
    }
}

extension MediaPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        didTapNext(nextButton)
    }
}
