//
//  FavoriteViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 27.10.2022.
//

import Foundation
import UIKit
import CoreData

class FavoriteViewController: UIViewController {

    private var viewModel: CoreDataManager?
    private weak var coordinator: FavoriteFlowCoordinator?
    private var post: PostData?


    let background: UIImageView = {
        let back = UIImageView()
        back.clipsToBounds = true
        back.image = UIImage(named: "tekstura")
        back.translatesAutoresizingMaskIntoConstraints = false
        return back
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: "FavoriteTableViewCell")
        return tableView
    }()


    init(model: CoreDataManager, coordinator: FavoriteFlowCoordinator) {
        self.viewModel = model
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "★ Избранное"
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = .white
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        CoreDataManager.shared.outFromCoreData()
        tableView.reloadData()
    }

    func layout() {
        
        [background, tableView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leftAnchor.constraint(equalTo: view.leftAnchor),
            background.rightAnchor.constraint(equalTo: view.rightAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FavoriteViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.favoritePost.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as? FavoriteTableViewCell else { return UITableViewCell() }
        let post = CoreDataManager.shared.favoritePost[indexPath.row]
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.backgroundColor = .white
        cell.myCells(post)
        return cell
    }
}
