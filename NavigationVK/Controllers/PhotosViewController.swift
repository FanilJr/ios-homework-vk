//
//  PhotosViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 21.08.2022.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    private var imagePublisherFacade: ImagePublisherFacade?
    var startTime = Date()
    let qos: QualityOfService = .background
    var imageFilter = [CGImage?]()
    var imageArray = [UIImage]()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Фотогалерея"
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        layout()
        
        ImageProcessor().processImagesOnThread(sourceImages: galery, filter: .monochrome(color: CIColor.init(red: 0/255, green: 0/255, blue: 0/255), intensity: 0.5), qos: qos) {
            self.imageFilter = $0
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        print("Изображения были обработаны в течении \(Date().timeIntervalSince(self.startTime)) секунд")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    }
    
    private func layout() {
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        var image = UIImage()
        let notAvilableImage = UIImage(systemName: "exclamationmark.icloud.fill")!
        if let cgImage = imageFilter[indexPath.row] {
            image = UIImage(cgImage: cgImage)
        } else {
            image = notAvilableImage
        }
        cell.pullCell(photo: image)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        imageFilter.count
        
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private var interSpace: CGFloat { return 8 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.width - interSpace * 4) / 3
        
        return CGSize(width: width, height: width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return interSpace
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        UIEdgeInsets(top: interSpace, left: interSpace, bottom: interSpace, right: interSpace)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return interSpace
        
    }
}

extension PhotosViewController: ImageLibrarySubscriber {
    
    func receive(images: [UIImage]) {
        imageArray = images
        collectionView.reloadData()
    }
}
