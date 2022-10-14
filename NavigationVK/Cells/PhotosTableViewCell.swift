//
//  PhotosTableViewCell.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 21.08.2022.
//

import UIKit

protocol MyClassDelegateTwo: AnyObject {
    func tuchUp()
   // func tuchToShare()
}

class PhotosTableViewCell: UITableViewCell {
            
    weak var tuchNew: MyClassDelegateTwo?
    
    private lazy var collectionViews: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
        return collectionView
    }()
        
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 27 / 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tuch), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tuch() {
        print("tuch по кнопке из TableViewCell")
        tuchNew?.tuchUp()
    }
    
    @objc private func tuchShare() {
        
    }
    
    private func layout() {
            
        [label, button, collectionViews].forEach { contentView.addSubview($0) }
                            
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                
            button.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 27),
            button.heightAnchor.constraint(equalToConstant: 27),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                
            collectionViews.topAnchor.constraint(equalTo: label.bottomAnchor),
            collectionViews.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            collectionViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            collectionViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            collectionViews.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

   

extension PhotosTableViewCell: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
        return galery.count
            
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
//        let menuIneraction = UIContextMenuInteraction(delegate: self)
//        cell.addInteraction(menuIneraction)
        cell.pullCell(photo: galery[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let recipe = galery[indexPath.row]
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in
            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                print("Share \(recipe)")
                let avc = UIActivityViewController(activityItems: [recipe], applicationActivities: nil)
            }
            let menu = UIMenu(title: "", children: [share])
            return menu
        })
        return configuration
    }
}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
        
    private var interSpace: CGFloat { return 10 }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
        let width = (collectionView.bounds.width - interSpace * 3) / 4
            
        return CGSize(width: width, height: width)
            
    }
}

//extension PhotosTableViewCell: UIContextMenuInteractionDelegate {
//
//    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
//        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
//            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
//                self.tuchShare()
//                print("Проверка фото")
//            }
//            return UIMenu(title: "", children: [share])
//        }
//    }
//}
