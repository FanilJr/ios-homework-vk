//
//  AlbumCell.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 05.10.2022.
//

import UIKit

class AlbumCell: UITableViewCell {
    
    lazy var albumCover: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 25
        return image
    }()
    
    lazy var albumName: UILabel = {
        let album = UILabel()
        album.translatesAutoresizingMaskIntoConstraints = false
        album.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        album.textColor = .black
        return album
    }()
    
    lazy var songsYears: UILabel = {
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
    
    func setupView() {
        [albumCover, albumName, songsYears].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            albumCover.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            albumCover.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            albumCover.widthAnchor.constraint(equalToConstant: 100),
            albumCover.heightAnchor.constraint(equalToConstant: 100),
            albumCover.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
            
            albumName.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            albumName.leadingAnchor.constraint(equalTo: albumCover.trailingAnchor,constant: 16),
            albumName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            
            songsYears.topAnchor.constraint(equalTo: albumName.bottomAnchor,constant: 8),
            songsYears.leadingAnchor.constraint(equalTo: albumCover.trailingAnchor,constant: 16),
            songsYears.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            songsYears.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor,constant: -16)
        ])
    }
}
