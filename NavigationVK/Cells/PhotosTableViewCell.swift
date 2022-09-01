//
//  PhotosTableViewCell.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 21.08.2022.
//

import UIKit

protocol MyClassDelegateTwo: AnyObject {
    func tuchUp()
}

class PhotosTableViewCell: UITableViewCell {
    
    
    //    MARK: - Инициализатор
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            layout()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
            
    //    MARK: - Создание и настройка объектов
    
    weak var tuchNew: MyClassDelegateTwo?
        
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
    
    ///  не то делаю
    @objc private func tuch() {
        
        print("tuch по кнопке из TableViewCell")
        tuchNew?.tuchUp()

    }
        
    //    MARK: - Коллекция
        
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
    
        //    MARK: - Расстановка объектов в ячейке
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

    //  MARK: - Расширение UICollectionViewDataSource

extension PhotosTableViewCell: UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            return galery.count
            
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
            cell.pullCell(photo: galery[indexPath.row])
            
            return cell
        }
    }

    //  MARK: - Расширение UICollectionViewDelegateFlowLayout

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
        
        private var interSpace: CGFloat { return 10 }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            let width = (collectionView.bounds.width - interSpace * 3) / 4
            
            return CGSize(width: width, height: width)
            
        }
    }