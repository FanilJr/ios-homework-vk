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
    var refreshControle = UIRefreshControl()
    private weak var coordinator: NewsFlowCoordinator?
    
    var searchController = UISearchController(searchResultsController: nil)

    let background: UIImageView = {
        let back = UIImageView()
        back.clipsToBounds = true
        back.image = UIImage(named: "tekstura")
        back.translatesAutoresizingMaskIntoConstraints = false
        return back
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
        tableView.refreshControl = refreshControle
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "NewsTableViewCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Новости"
        refreshControle.attributedTitle = NSAttributedString(string: "Update")
        refreshControle.addTarget(self, action: #selector(didTapRefresh), for: .valueChanged)
        activityView.startAnimating()
        
//        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefresh))
        
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
                self.refreshControle.endRefreshing()
            }
        }
    }
    
    func layout() {
        [background, activityView,tableView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityView.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: background.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: background.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: background.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: background.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: background.bottomAnchor)
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
        cell.backgroundColor = .white
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Новости сегодня"
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


