//
//  PostTableViewCell.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 21.08.2022.
//

import Foundation
import UIKit

class PostTableViewCell: UITableViewCell {
    
    lazy var postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var authorName: UILabel = {
        let label = UILabel()
        label.textColor = .black
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
        label.textColor = .black
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
        label.textColor = .black
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
    
    weak var viewModel: PostTbaleViewCellModel? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            authorName.text = viewModel.author
            descriptionLabel.text = viewModel.description
            postImage.image = UIImage(named: viewModel.image)
            likes.text = "Likes: \(viewModel.likes)"
            viewsLabel.text = "Views: \(viewModel.views)"
        }
        
    
    }
    func setupNewCell(_ model: PostTbaleViewCellModel) {
        postImage.image = UIImage(named: model.image)
        authorName.text = model.author
        descriptionLabel.text = model.description
        likes.text = "Likes: \(String(model.likes))"
        viewsLabel.text = "Views: \(String(model.views))"
    }
    
    func setupCell(_ model: PostStruct) {
        postImage.image = UIImage(named: model.image)
        authorName.text = model.author
        descriptionLabel.text = model.description
        likes.text = "Likes: \(String(model.likes))"
        viewsLabel.text = "Views: \(String(model.views))"
    }
//      MARK: ?????????????? ???????????? ?????????????? ?????? ???????? ????????
//
//        if let image = UIImage(named: model.image) {
//
//            let filter = ColorFilter.monochrome(color: CIColor.init(red: 0/255, green: 0/255, blue: 0/255), intensity: 0.7)
//            ImageProcessor().processImage(sourceImage: image, filter: filter) { postImage.image = $0 }
//
//        }
//      MARK: ???????????????? ????????????????
        
//            let filter2 = ColorFilter.tonal
//            let filter3 = ColorFilter.noir
//            let filter4 = ColorFilter.posterize
//            let filter5 = ColorFilter.fade
//            let filter6 = ColorFilter.process
//            let filter7 = ColorFilter.transfer
            
//      MARK: ?????????????????? ??????????????
            
//            if let image = UIImage(named: model.image) {
//                let filter = ColorFilter.allCases[Int.random(in: 0..<ColorFilter.allCases.count)]
//                ImageProcessor().processImage(sourceImage: image, filter: filter) {postImage.image = $0 }
//            }
            
//      MARK: ?????????????? ???????????????????? ???????????????? ???? ???????????????? ??????????
            
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
        
        [postImage, authorName, descriptionLabel, likes, viewsLabel].forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            authorName.topAnchor.constraint(equalTo: contentView.topAnchor),
            authorName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            authorName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            authorName.heightAnchor.constraint(equalToConstant: 50),
            
            postImage.topAnchor.constraint(equalTo: authorName.bottomAnchor),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImage.heightAnchor.constraint(equalToConstant: 400),
            
            descriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor,constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 14),
            /// ???????????? ??????????????????  ????-???? ???????????? description
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
