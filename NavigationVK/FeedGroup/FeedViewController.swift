//
//  FeedViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 21.08.2022.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {

    let model: FeedModel
    var post = Postik(title: "Заголовок поста")
    let splash = SplashViewController()
    lazy var feedView = FeedView(delegate: self)
    private var coordinator: FeedFlowCoordinator?

    init(model: FeedModel, coordinator: FeedFlowCoordinator) {
        
        self.model = model
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Лента"
        NotificationCenter.default.addObserver(self, selector: #selector(notificationAction), name: .updateIsValidWord, object: nil)
        layout()
    }

    @objc private func notificationAction(_ notification: Notification) {
        
        guard let result = notification.object as? Bool else {
            let object = notification.object as Any
            assertionFailure("Invalid object: \(object)")
            return
        }
        feedView.setResultLabel(result: result)
    }

    private func layout() {
    
        view.addSubview(feedView)
        view.addSubview(splash)
        
        NSLayoutConstraint.activate([
            
            splash.topAnchor.constraint(equalTo: view.topAnchor),
            splash.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            splash.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            splash.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            feedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedView.topAnchor.constraint(equalTo: view.topAnchor),
            feedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FeedViewController: FeedViewDelegate {

   func didTapPostButton() {
       coordinator?.showPost(title: post.title)
    }

    func check(word: String) {
        model.check(word: word)
    }
}
