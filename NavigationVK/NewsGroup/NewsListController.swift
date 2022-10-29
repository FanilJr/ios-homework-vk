//
//  NewsListController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 25.10.2022.
//

import UIKit

class NewsListController: UIViewController {
    
    var downloadManager = DownloadManager()
    var articles: [Article] = []
    var article: Article!
    
    var searchController = UISearchController(searchResultsController: nil)

    private var downloadLabel: UILabel = {
        let download = UILabel()
        download.text = "Загрузка"
        download.translatesAutoresizingMaskIntoConstraints = false
        return download
    }()
    
    private var activityView: UIActivityIndicatorView = {
        let activityView: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
        activityView.hidesWhenStopped = true
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
    }()
    
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
        activityView.startAnimating()
        
//        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefresh))
        
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        activityView.stopAnimating()
    }

    @objc func didTapRefresh() {
        downloadNewsList { articles in
            DispatchQueue.main.async {
                self.articles = articles ?? []
                self.tableView.reloadData()
            }
        }
    }
    
    func layout() {
        [activityView,tableView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
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


