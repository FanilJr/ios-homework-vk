//
//  ArticleTableViewCell.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 25.10.2022.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
//    var articles: Article!
    
    //MARK: ДОДЕЛАТЬ АКТИВИТИ - НЕ РАБОТАЕТ
    private var activityView: UIActivityIndicatorView = {
        let activityView: UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityView.hidesWhenStopped = true
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    
    lazy var progress: UIProgressView = {
        let progress = UIProgressView()
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    lazy var postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var name: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var url: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionName: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var date: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constraints()
//        postImage.image = UIImage(systemName: "photo.artframe")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func showImage() {
//        if let urlImageString = articles.urlToImage,
//           let urlImage = URL(string: urlImageString) {
//            downloadImage(urlImage: urlImage) { imageData in
//                guard let imageData else { return }
//
//                DispatchQueue.main.async {
//                    self.postImage.image = UIImage(data: imageData)
//                }
//            }
//        }
//    }
    
    private func constraints() {
        [date, progress, postImage, titleName, descriptionName, url].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            date.topAnchor.constraint(equalTo: contentView.topAnchor),
            date.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            date.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            
            postImage.topAnchor.constraint(equalTo: date.bottomAnchor,constant: 5),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            postImage.heightAnchor.constraint(equalToConstant: 200),
            
            progress.centerYAnchor.constraint(equalTo: postImage.centerYAnchor),
            progress.centerXAnchor.constraint(equalTo: postImage.centerXAnchor),
            progress.widthAnchor.constraint(equalToConstant: 250),
            progress.heightAnchor.constraint(equalToConstant: 5),
            
            titleName.topAnchor.constraint(equalTo: postImage.bottomAnchor,constant: 5),
            titleName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            titleName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            
            descriptionName.topAnchor.constraint(equalTo: titleName.bottomAnchor,constant: 16),
            descriptionName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 14),
            descriptionName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -14),
            
            url.topAnchor.constraint(equalTo: descriptionName.bottomAnchor,constant: 16),
            url.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 14),
            url.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -14),
            url.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
        ])
    }
}
