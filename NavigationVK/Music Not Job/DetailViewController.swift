//
//  DetailViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 05.10.2022.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate {

    
    lazy var imageview: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(AlbumTableViewCell.self, forCellReuseIdentifier: "cell")
        table.estimatedRowHeight = 132
        table.rowHeight = UITableView.automaticDimension
        table.tableFooterView = UIView()
        return table
    }()

    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 70)
        button.setImage(UIImage(systemName: "play.circle.fill", withConfiguration: config), for: .normal)
        button.addTarget(self, action: #selector(playButtonPressed(_:)), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 70)
        button.setImage(UIImage(systemName: "play.circle.fill", withConfiguration: config), for: .normal)
        button.addTarget(self, action: #selector(nextButtonPressed(_:)), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 70)
        button.setImage(UIImage(systemName: "play.circle.fill", withConfiguration: config), for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    var player: PlayerNew!
    var paused: Bool
    
    var album: AlbumMusic! { // This is our `detailItem`.  should be an optional?
        didSet {
            self.player = PlayerNew( album: album )  // yeah, i'd rather this crash at this point
            self.player.delegate = self
            
            // Update the view.
            self.configureView()
        }
    }
    
    
    init(paused: Bool) {
        self.paused = paused
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    func layuout() {
        [playButton, backButton,nextButton,tableView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: view.topAnchor),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.topAnchor.constraint(equalTo: view.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nextButton.topAnchor.constraint(equalTo: view.topAnchor),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        
            tableView.topAnchor.constraint(equalTo: playButton.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    @objc func playButtonPressed(_ sender: UIButton) {
        if player.playing {
            player.pause()
        } else {
            player.play()
        }
        
        updatePlayButton()
        updateNextButton()
        
        self.paused = !self.paused
    }
    
    @objc func nextButtonPressed(_ sender: UIButton) {
        player.nextTrack()
        updateBackButton()
        updateNextButton()
    }
    
    @objc func backButtonPressed(_ sender: AnyObject) {
        player.previousTrack()
        updateBackButton()
        updateNextButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        if album != nil {
            let newTitle = album.description
            self.title = newTitle
            if self.imageview != nil {
                self.imageview.image = UIImage( named: album.filenameFor1400image )
            }
            self.paused = false
            if backButton != nil {
                updateBackButton()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.player.stop()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        self.layuout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return album.totalTracks
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as? DetailCell else {
            return UITableViewCell()
        }
        let trackNumber = indexPath.row + 1
        cell.trackNumberButton.setImage( nil, for: .normal )
        
        if (trackNumber != self.player.trackNumber) {
            // for most tracks, just displaying the track number.  no icon.  simple.
            cell.trackNumberButton.setTitle( "\(trackNumber)", for: .normal )
        } else {
            // for current track, display an icon (so the user knows which track is currently playing or will play if the user pressed "play")
            let filename = self.player.playing ? "thisTrackIsPlaying.png" : "thisTrackIsPaused.png"
            let image = UIImage( named: filename )
            cell.trackNumberButton.setImage( image, for: .normal )
        }
        cell.trackNameLabel.text = self.player.album.tracks[indexPath.row]
        cell.trackDurationLabel.text = "3:54"
        return cell
    }
    
    private func tableView( tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath )
    {
        let trackNumber = indexPath.row + 1
        player.selectTrack( trackNumber: trackNumber )
        player.play()
        updatePlayButton()
        updateBackButton()
        updateNextButton()
    }
    
    func updateTableRows() {
        if let indexPaths = self.tableView.indexPathsForVisibleRows {
            self.tableView.reloadRows( at: indexPaths, with: UITableView.RowAnimation.none )
        }
    }
    
    func updatePlayButton() {
        let filename = player.playing ? "pause.png" : "play.png"
        let image = UIImage( named: filename )
        playButton.setImage( image, for: .normal )
    }
    
    func updateBackButton() {
        self.backButton.isEnabled = !self.player.firstTrack
        updateTableRows()
    }
    
    func updateNextButton() {
        self.nextButton.isEnabled = !self.player.lastTrack
        updateTableRows()
    }
    
    func audioPlayerDidFinishPlaying( playerNotToUse: AVAudioPlayer, successfully flag: Bool) {
        if self.player.lastTrack {
            updatePlayButton()
        } else {
            self.player.nextTrack()
            self.player.play()
            updateNextButton()
            updateBackButton()
        }
    }
}

