//
//  MusicViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 05.10.2022.
//

import UIKit
import CoreData

class MusicViewController: UIViewController {
    
    var catalog: Catalog
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(AlbumCell.self, forCellReuseIdentifier: "AlbumCell")
        table.estimatedRowHeight = 132
        table.rowHeight = UITableView.automaticDimension
        table.tableFooterView = UIView()
        return table
    }()
    
    init(catalog: Catalog) {
        self.catalog = catalog
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension MusicViewController: UITableViewDelegate {

}

extension MusicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as? AlbumCell else {
           return UITableViewCell()
       }

        let album = self.catalog.albums[indexPath.row]
        cell.albumCover.image = UIImage(named: album.filenameFor1400image)
        cell.albumName.text = album.title
        cell.songsYears.text = album.year
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = DetailViewController(paused: true)
        detailController.album = self.catalog.albums[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    
}



