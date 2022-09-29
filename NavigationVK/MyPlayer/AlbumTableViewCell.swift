//
//  AlbumTableViewCell.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 27.09.2022.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    var album: Album? {
        didSet {
            if let album = album {
                albumCover.image = UIImage(named: album.image)
                albumName.text = album.name
                songsCount.text = "\(album.songs.count) Songs"
            }
        }
    }
    
    private lazy var albumCover: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 25
        return image
    }()
    
    private lazy var albumName: UILabel = {
        let album = UILabel()
        album.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        album.textColor = .black
        album.translatesAutoresizingMaskIntoConstraints = false
        return album
    }()
    
    private lazy var songsCount: UILabel = {
        let songs = UILabel()
        songs.translatesAutoresizingMaskIntoConstraints = false
        songs.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        songs.numberOfLines = 0
        songs.textColor = .darkGray
        return songs
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [albumCover, albumName, songsCount].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            albumCover.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            albumCover.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            albumCover.widthAnchor.constraint(equalToConstant: 100),
            albumCover.heightAnchor.constraint(equalToConstant: 100),
            albumCover.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
            
            albumName.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            albumName.leadingAnchor.constraint(equalTo: albumCover.trailingAnchor,constant: 16),
            albumName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            
            songsCount.topAnchor.constraint(equalTo: albumName.bottomAnchor,constant: 8),
            songsCount.leadingAnchor.constraint(equalTo: albumCover.trailingAnchor,constant: 16),
            songsCount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            songsCount.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor,constant: -16)
        ])
    }
}
