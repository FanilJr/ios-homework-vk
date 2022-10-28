//
//  SongListViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 30.09.2022.
//

import UIKit

class SongListViewController: UIViewController {

    var album: Album!
    var albums: [Album] = []
    

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(SongListTableViewCell.self, forCellReuseIdentifier: "SongListTableViewCell")
        table.estimatedRowHeight = 132
        table.rowHeight = UITableView.automaticDimension
        table.tableFooterView = UIView()
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        
        [tableView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    static func show(_ viewController: UIViewController, album: Album) {
        let ac = SongListViewController()
        ac.album = album
        viewController.navigationController?.pushViewController(ac, animated: true)
    }

}

extension SongListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongListTableViewCell", for: indexPath) as? SongListTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
