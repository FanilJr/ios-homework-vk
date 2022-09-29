//
//  PlayerViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 27.09.2022.
//

import UIKit

class PlayerViewController: UIViewController {
    
    let albums = Album.get()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
//        table.backgroundColor = .clear
        table.register(AlbumTableViewCell.self, forCellReuseIdentifier: "cell")
        table.estimatedRowHeight = 132
        table.rowHeight = UITableView.automaticDimension
        table.tableFooterView = UIView()
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Music Player"
        setupView()

    }
    
    func setupView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension PlayerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AlbumTableViewCell else {
            return UITableViewCell()
        }
//        cell.backgroundColor = .clear
        cell.album = albums[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MediaPlayerViewController(album: albums[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        present(vc, animated: true)
    }
}
