//
//  ArticleViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 25.10.2022.
//

import UIKit

class ArticleViewController: UIViewController {

    var articles: Article!
    var downloadManager = DownloadManager()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleTableViewCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Пост"
        layout()
        tableView.dataSource = self
        tableView.delegate = self
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
    
    static func show(_ viewController: UIViewController, article: Article) {
        let ac = ArticleViewController()
        ac.articles = article
        viewController.navigationController?.pushViewController(ac, animated: true)
    }
}

extension ArticleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.titleName.text = articles.title
        cell.descriptionName.text = articles.description
        cell.name.text = articles.name
        cell.url.text = articles.url
        cell.date.text = articles.publishedAt
        
        
        
        if let urlImageString = articles.urlToImage,
           let urlimage = URL(string: urlImageString) {
            downloadManager.downloadFile(url: urlimage) { data in
                guard let data else {
                    return
                }
                DispatchQueue.main.async {
                    cell.postImage.image = UIImage(data: data)
                }
            } didWriteData: { percentCompleted in
                DispatchQueue.main.async {
                    cell.progress.progress = percentCompleted
                }
            }

//            downloadFile(urlImage: urlimage) { imageData in
//                guard let imageData else {
//                    return
//                }
//                DispatchQueue.main.async {
//                    cell.postImage.image = UIImage(data: imageData)
//                }
//            }
            
//            downloadImage(urlImage: urlimage) { imageData in
//                guard let imageData else { return }
//                DispatchQueue.main.async {
//                    cell.postImage.image = UIImage(data: imageData)
//                }
//            }
        }
        return cell
    }
}


extension ArticleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

