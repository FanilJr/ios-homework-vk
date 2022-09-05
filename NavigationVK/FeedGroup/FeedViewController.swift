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
    let splash = SplashView()
    lazy var feedView = FeedView(delegate: self)
    private var coordinator: FeedFlowCoordinator?
    
    let background: UIImageView = {
        let back = UIImageView()
        back.image = UIImage(named: "background")
        back.translatesAutoresizingMaskIntoConstraints = false
        return back
    }()

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
        
        [background,feedView,splash].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            splash.topAnchor.constraint(equalTo: view.topAnchor),
            splash.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            splash.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            splash.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            feedView.leadingAnchor.constraint(equalTo: background.leadingAnchor),
            feedView.trailingAnchor.constraint(equalTo: background.trailingAnchor),
            feedView.topAnchor.constraint(equalTo: background.topAnchor),
            feedView.bottomAnchor.constraint(equalTo: background.bottomAnchor)
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
