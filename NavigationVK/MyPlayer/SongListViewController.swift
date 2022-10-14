//
//  SongListViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 30.09.2022.
//

import UIKit

class SongListViewController: UIViewController {

    var songListTable = SongListTableViewCell()
    var firstAlbum = FirstAlbum.massiveAlbum()
    var secondAlbum = SecondAlbum.massiveAlbum()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(SongListTableViewCell.self, forCellReuseIdentifier: "cell")
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
}

extension SongListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstAlbum.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SongListTableViewCell else {
            return UITableViewCell()
        }
        cell.setupFirstAlbum(firstAlbum[indexPath.row])
        return cell
    }
}
