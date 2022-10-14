//
//  SongListTableViewCell.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 30.09.2022.
//

import UIKit

class SongListTableViewCell: UITableViewCell {

    lazy var songName: UILabel = {
        let album = UILabel()
        album.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        album.textColor = .black
        album.translatesAutoresizingMaskIntoConstraints = false
        return album
    }()
    
    lazy var imageSong: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupFirstAlbum(_ model: FirstAlbum) {
        songName.text = model.track
        imageSong.image = UIImage(named: model.image)
        
    }
    
    func setupSecondAlbum(_ model: SecondAlbum) {
        songName.text = model.track
        imageSong.image = UIImage(named: model.image)
        
    }
    
    private func setupView() {
        [songName, imageSong].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            songName.topAnchor.constraint(equalTo: contentView.topAnchor),
            songName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            imageSong.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageSong.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageSong.heightAnchor.constraint(equalToConstant: 30),
            imageSong.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
