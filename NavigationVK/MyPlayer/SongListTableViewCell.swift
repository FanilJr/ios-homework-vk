//
//  SongListTableViewCell.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 30.09.2022.
//

import UIKit

class SongListTableViewCell: UITableViewCell {
    var album: Album? {
        didSet {
            if let album = album {
                songName.text = "\(album.songs)"
            }
        }
    }
    
    lazy var songName: UILabel = {
        let album = UILabel()
        album.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        album.textColor = .black
        album.translatesAutoresizingMaskIntoConstraints = false
        return album
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [songName].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            
            songName.topAnchor.constraint(equalTo: songName.bottomAnchor),
            songName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
}
