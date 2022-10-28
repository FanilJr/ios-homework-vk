//
//  PlayerViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 27.09.2022.
//

import UIKit

class PlayerViewController: UIViewController {
    
    let albums = Album.get()
    
    let background: UIImageView = {
        let back = UIImageView()
        back.image = UIImage(named: "tekstura")
        back.translatesAutoresizingMaskIntoConstraints = false
        return back
    }()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(AlbumTableViewCell.self, forCellReuseIdentifier: "cell")
        table.estimatedRowHeight = 132
        table.backgroundColor = .clear
        table.rowHeight = UITableView.automaticDimension
        table.tableFooterView = UIView()
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Music"
        setupView()

    }
        
    func setupView() {
        
        [background, tableView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            tableView.topAnchor.constraint(equalTo: background.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: background.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: background.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: background.bottomAnchor)
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
        cell.album = albums[indexPath.row]
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MediaPlayerViewController(album: albums[indexPath.row])
        present(vc, animated: true)
//        let vc2 = SongListViewController()
//        navigationController?.pushViewController(vc2, animated: true)
        
//        let album = albums[indexPath.row]
//        SongListViewController.show(self, album: album)
    }
}
