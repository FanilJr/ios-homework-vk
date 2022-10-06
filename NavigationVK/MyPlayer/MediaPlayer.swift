//
//  MediaPlayer.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 27.09.2022.
//

import Foundation
import UIKit
import AVKit
import MediaPlayer

final class MediaPlayer: UIView {
    
    private var album: Album
    private var player = AVAudioPlayer()
    private var timer: Timer?
    private var playingIndex = 0
    
    private lazy var lineUp: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .darkGray
        line.alpha = 0.5
        line.contentMode = .scaleAspectFill
        line.layer.cornerRadius = 3
        line.clipsToBounds = true
        return line
    }()
    
    private lazy var line: UIImageView = {
        let line = UIImageView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .darkGray
        line.image = UIImage(named: "gradientLine")
        line.contentMode = .scaleAspectFill
        line.layer.cornerRadius = 2
        line.clipsToBounds = true
        return line
    }()

    private lazy var albumName: UILabel = {
        let album = UILabel()
        album.translatesAutoresizingMaskIntoConstraints = false
        album.textColor = .black
        album.layer.shadowOpacity = 1
        album.layer.shadowRadius = 10
        album.layer.shadowColor = UIColor.black.cgColor
        album.textAlignment = .center
        album.font = .systemFont(ofSize: 21, weight: .bold)
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
    
    private lazy var volumeBar: UISlider = {
        let slider = UISlider()
        slider.thumbTintColor = .clear
        slider.minimumTrackTintColor = #colorLiteral(red: 0.9294139743, green: 0.2863991261, blue: 0.3659052849, alpha: 1)
        slider.maximumTrackTintColor = .gray
        let config = UIImage.SymbolConfiguration(hierarchicalColor: UIColor.darkGray)
        slider.minimumValueImage = UIImage(systemName: "speaker.fill", withConfiguration: config)
        slider.maximumValueImage = UIImage(systemName: "speaker.wave.3.fill", withConfiguration: config)
        slider.minimumValueImage?.withTintColor(UIColor.darkGray)
        let tapGesture = UITapGestureRecognizer()
        slider.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self, action: #selector(bounceSlider))
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(progressVolume(_:)), for: .valueChanged)
        return slider
    }()

    private lazy var progressBar: UISlider = {
        let slider = UISlider()
        slider.thumbTintColor = .clear
        slider.minimumTrackTintColor = #colorLiteral(red: 0.9294139743, green: 0.2863991261, blue: 0.3659052849, alpha: 1)
        slider.maximumTrackTintColor = .gray
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
        label.textColor = .black
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
        button.setImage(UIImage(systemName: "backward.fill", withConfiguration: config), for: .normal)
        button.addTarget(self, action: #selector(didTapPrevious(_:)), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    private lazy var playPauseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 70)
        button.setImage(UIImage(systemName: "play.circle.fill", withConfiguration: config), for: .normal)
        button.addTarget(self, action: #selector(didTapPlayPause(_:)), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        button.setImage(UIImage(systemName: "forward.fill", withConfiguration: config), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTapNext(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var repeatButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 25)
        button.setImage(UIImage(systemName: "repeat.circle", withConfiguration: config), for: .normal)
        button.addTarget(self, action: #selector(didTapRepeat(_:)), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    private lazy var list: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 20)
        button.setImage(UIImage(systemName: "list.bullet", withConfiguration: config), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(openList), for: .touchUpInside)
        return button
    }()
    
    private lazy var airplay: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 20)
        button.setImage(UIImage(systemName: "airplayaudio", withConfiguration: config), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(openMenuAirPlay), for: .touchUpInside)
        return button
    }()
    
    private lazy var textSong: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 20)
        button.setImage(UIImage(systemName: "quote.bubble", withConfiguration: config), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(openMenuAirPlay), for: .touchUpInside)
        return button
    }()
    
    private lazy var dockStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [textSong, airplay, list])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 70
        return stack
    }()
    
    private lazy var controlStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [previousButton, playPauseButton, nextButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 50
        return stack
    }()

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
        
        [lineUp,albumName,line,albumCover,songNameLabel,repeatButton,artistLabel,progressBar,elapsedTimeLabel,remainingTimeLabel,controlStack,volumeBar, dockStack].forEach { addSubview($0) }
        setupConstraints()
        setUpRemoteTransparentControls()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            lineUp.topAnchor.constraint(equalTo: topAnchor,constant: 32),
            lineUp.centerXAnchor.constraint(equalTo: centerXAnchor),
            lineUp.widthAnchor.constraint(equalToConstant: 35),
            lineUp.heightAnchor.constraint(equalToConstant: 5),
            
            albumName.topAnchor.constraint(equalTo: lineUp.bottomAnchor,constant: 32),
            albumName.leadingAnchor.constraint(equalTo: leadingAnchor),
            albumName.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            line.topAnchor.constraint(equalTo: albumName.bottomAnchor),
            line.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 32),
            line.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -32),
            line.heightAnchor.constraint(equalToConstant: 3),
        
            albumCover.topAnchor.constraint(equalTo: line.bottomAnchor,constant: 32),
            albumCover.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            albumCover.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            albumCover.heightAnchor.constraint(equalToConstant: 300),
            
            songNameLabel.topAnchor.constraint(equalTo: albumCover.bottomAnchor,constant: 16),
            songNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            songNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            
            repeatButton.centerYAnchor.constraint(equalTo: songNameLabel.centerYAnchor),
            repeatButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            
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
            controlStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            volumeBar.topAnchor.constraint(equalTo: controlStack.bottomAnchor,constant: 8),
            volumeBar.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            volumeBar.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -6),
            
            dockStack.topAnchor.constraint(equalTo: volumeBar.bottomAnchor,constant: 24),
            dockStack.centerXAnchor.constraint(equalTo: centerXAnchor)
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
        playPauseButton.tintColor = isPlaying ? #colorLiteral(red: 0.9294139743, green: 0.2863991261, blue: 0.3659052849, alpha: 1) : .black
        playPauseButton.backgroundColor = isPlaying ? .black : .clear
        playPauseButton.layer.cornerRadius = isPlaying ? 40 : 0
    }
    
    @objc private func progressVolume(_ sender: UISlider) {
        player.volume = sender.value
    }
    
    @objc private func updateProgress() {
       progressBar.value = Float(player.currentTime)
       
       elapsedTimeLabel.text = getFormattedTime(timeInterval: player.currentTime)
       let remainingTime = player.duration - player.currentTime
       remainingTimeLabel.text = "-\(getFormattedTime(timeInterval: remainingTime))"
    }

    @objc func progressScrubbed(_ sender: UISlider) {
        player.currentTime = Float64(sender.value)

    }
    
    @objc func openList() {
        
    }
    
    @objc func openMenuAirPlay() {
        
    }
    
    @objc func bounceSlider() {
        //MARK: ДОДЕЛАТЬ!!!!!!!!!!!!!!!!!!!!
        if volumeBar.state == .highlighted {
            
            UIView.animate(withDuration: 0.5) {
                let scale = self.volumeBar.frame
                self.volumeBar.transform = CGAffineTransform(scaleX: 1, y: 2)
            }
        }
    }
    
    @objc func didTapRepeat(_ sender: UIButton) {
        if sender.tintColor == #colorLiteral(red: 0.9294139743, green: 0.2863991261, blue: 0.3659052849, alpha: 1)  {
            let config = UIImage.SymbolConfiguration(pointSize: 25)
            sender.setImage(UIImage(systemName: "repeat.circle", withConfiguration: config), for: .normal)
            sender.tintColor = .black
            sender.backgroundColor = .clear


        } else {
            let config = UIImage.SymbolConfiguration(pointSize: 25)
            sender.setImage(UIImage(systemName: "repeat.1.circle.fill", withConfiguration: config), for: .normal)
            sender.backgroundColor = .black
            sender.layer.cornerRadius = 14
            sender.tintColor = #colorLiteral(red: 0.9294139743, green: 0.2863991261, blue: 0.3659052849, alpha: 1)
        }
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
    
    func setUpRemoteTransparentControls() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.addTarget{
            event in
            if self.player.isPlaying{
                self.player.play()


                return .success
            }
            return .commandFailed
        }
           commandCenter.pauseCommand.addTarget{
                 event in
               if self.player.isPlaying{
                   self.player.pause()
                     return .success
                 }
                 return .commandFailed
             }
        
        commandCenter.nextTrackCommand.addTarget{
            event in
            if self.player.isPlaying {
                self.playingIndex += 1
                if self.playingIndex >= self.album.songs.count {
                    self.playingIndex = 0
                }
                self.setupPlayer(song: self.album.songs[self.playingIndex])
                self.play()
                self.setPlayPauseIcon(isPlaying: self.player.isPlaying)
                return .success
            }
            return .commandFailed
        }
        commandCenter.previousTrackCommand.addTarget{
                  event in
            if self.player.isPlaying {
                self.playingIndex -= 1
                if self.playingIndex < 0 {
                    self.playingIndex = self.album.songs.count - 1
                }
                self.setupPlayer(song: self.album.songs[self.playingIndex])
                self.play()
                self.setPlayPauseIcon(isPlaying: self.player.isPlaying)

                      return .success
                  }
                  return .commandFailed
              }
        
        commandCenter.changePlaybackPositionCommand.addTarget(self, action: #selector(changeThumbSlider(_:)))
    }
    
    @objc func changeThumbSlider ( _ event : MPChangePlaybackPositionCommandEvent) -> MPRemoteCommandHandlerStatus{
        player.currentTime = event.positionTime
        
        return .success
    }
}

extension MediaPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        didTapNext(nextButton)
    }
}
