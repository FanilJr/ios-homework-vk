//
//  PostTableViewCell.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 21.08.2022.
//

import Foundation
import UIKit

class PostTableViewCell: UITableViewCell {
    
    
    private lazy var lineUp: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .black
        line.contentMode = .scaleAspectFill
        line.layer.cornerRadius = 3
        line.clipsToBounds = true
        return line
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 3
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var name: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    lazy var avatarImageView: UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = UIColor.black.cgColor
        avatarImageView.layer.cornerRadius = 60/2
        avatarImageView.clipsToBounds = true
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        return avatarImageView
    }()
    
    lazy var status: UILabel = {
        let status = UILabel()
        status.font = UIFont.systemFont(ofSize: 12.0, weight: .light)
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    lazy var postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var authorName: UILabel = {
        let label = UILabel()
        label.textColor = .createColor(light: .black, dark: .white)
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .light)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likes: UILabel = {
        let label = UILabel()
        label.textColor = .createColor(light: .black, dark: .white)
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var imageLike: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "heart3")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .createColor(light: .black, dark: .white)
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    public func configure(with post: Post) {
        authorName.text = post.author
        descriptionLabel.text = post.description
        likes.text = "Likes: \(post.likes)"
        viewsLabel.text = "Views: \(post.views)"
        postImage.image = UIImage(named: post.image)
    }
    
//      MARK: вариант одного фильтра для всех фото
//
//        if let image = UIImage(named: model.image) {
//
//            let filter = ColorFilter.monochrome(color: CIColor.init(red: 0/255, green: 0/255, blue: 0/255), intensity: 0.7)
//            ImageProcessor().processImage(sourceImage: image, filter: filter) { postImage.image = $0 }
//
//        }
//      MARK: варианты фильтров
        
//            let filter2 = ColorFilter.tonal
//            let filter3 = ColorFilter.noir
//            let filter4 = ColorFilter.posterize
//            let filter5 = ColorFilter.fade
//            let filter6 = ColorFilter.process
//            let filter7 = ColorFilter.transfer
            
//      MARK: рандомный вариант
            
//            if let image = UIImage(named: model.image) {
//                let filter = ColorFilter.allCases[Int.random(in: 0..<ColorFilter.allCases.count)]
//                ImageProcessor().processImage(sourceImage: image, filter: filter) {postImage.image = $0 }
//            }
            
//      MARK: вариант применения фильтров по заданому имени
            
//            if image == UIImage(named: "P1") {
//            ImageProcessor().processImage(sourceImage: image, filter: filter) { postImage.image = $0 }
//
//            } else if image == UIImage(named: "P2") {
//                ImageProcessor().processImage(sourceImage: image, filter: filter2) { postImage.image = $0 }
//
//            } else if image == UIImage(named: "P3") {
//                ImageProcessor().processImage(sourceImage: image, filter: filter3) { postImage.image = $0 }
//
//            } else if image == UIImage(named: "P4") {
//                ImageProcessor().processImage(sourceImage: image, filter: filter4) { postImage.image = $0 }
//
//            } else if image == UIImage(named: "P5") {
//                ImageProcessor().processImage(sourceImage: image, filter: filter5) { postImage.image = $0 }
//
//            } else if image == UIImage(named: "P6") {
//                ImageProcessor().processImage(sourceImage: image, filter: filter6) { postImage.image = $0 }
//
//            } else if image == UIImage(named: "P7") {
//                ImageProcessor().processImage(sourceImage: image, filter: filter7) { postImage.image = $0 }
//
//            }
   
    private func constraints() {
        
        [avatarImageView, stackView, lineUp, postImage, authorName, descriptionLabel, likes, viewsLabel].forEach { contentView.addSubview($0) }
        [name, status].forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            stackView.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: 10),
            
            lineUp.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor,constant: 15),
            lineUp.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            lineUp.widthAnchor.constraint(equalToConstant: 300),
            lineUp.heightAnchor.constraint(equalToConstant: 1),
            
            authorName.topAnchor.constraint(equalTo: lineUp.bottomAnchor),
            authorName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            authorName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
//            authorName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            authorName.heightAnchor.constraint(equalToConstant: 50),
            
            postImage.topAnchor.constraint(equalTo: authorName.bottomAnchor),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: 400),
            
            descriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor,constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 14),
            /// ошибка возникает  из-за высоты description
            //descriptionLabel.heightAnchor.constraint(equalToConstant: 25),

            likes.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            likes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            likes.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            likes.heightAnchor.constraint(equalToConstant: 50),
            likes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            viewsLabel.heightAnchor.constraint(equalToConstant: 50),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
