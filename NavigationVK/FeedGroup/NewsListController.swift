//
//  NewsListController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 25.10.2022.
//

import UIKit

class NewsListController: UIViewController {
    
    var articles: [Article] = []
    var article: Article!
    
    var searchController = UISearchController(searchResultsController: nil)

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Новости"
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        
        layout()
        tableView.dataSource = self
        tableView.delegate = self
        
        downloadNewsList { articles in
            DispatchQueue.main.async {
                self.articles = articles ?? []
                self.tableView.reloadData()
            }
        }
    }
    
    func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

    // MARK: - Table view data source
    
extension NewsListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.setupCell(articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        ArticleViewController.show(self, article: article)
    }
}


extension NewsListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension NewsListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        downloadNewsList(searchString: searchController.searchBar.text) { articles in
            DispatchQueue.main.async {
                self.articles = articles ?? []
                self.tableView.reloadData()
            }
        }
    }
    
    
}
