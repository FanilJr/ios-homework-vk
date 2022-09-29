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
    let player = Player()
    lazy var feedView = FeedView(delegate: self)
    private var coordinator: FeedFlowCoordinator?
    
    var blure: UIVisualEffectView = {
        let bluereEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blure = UIVisualEffectView()
        blure.effect = bluereEffect
        blure.translatesAutoresizingMaskIntoConstraints = false
        blure.clipsToBounds = true
        blure.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer()
        
        gesture.addTarget(self, action: #selector(removeBlure))
        blure.alpha = 0
        return blure
    }()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(removeBlure))
        blure.addGestureRecognizer(gesture)
    }

    @objc private func notificationAction(_ notification: Notification) {
        
        guard let result = notification.object as? Bool else {
            let object = notification.object as Any
            assertionFailure("Invalid object: \(object)")
            return
        }
        feedView.setResultLabel(result: result)
    }
    
   @objc func removeBlure() {

       UIView.animate(withDuration: 0.5, animations: {
           self.player.alpha = 1
           self.player.transform = CGAffineTransform(translationX: 0, y: 0)
           self.blure.alpha = 0
           self.player.player?.stop()
           self.player.playButton.setImage(UIImage(named: "play"), for: .normal)
           self.tabBarController?.tabBar.isHidden = false
           self.navigationController?.navigationBar.isHidden = false
       })
       tabBarController?.tabBar.isHidden = false
       DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
           self.player.removeFromSuperview()
           self.blure.removeFromSuperview()
       }
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
    func didTapSecondPostButton() {
        coordinator?.showSecondPost(title: post.title)
    }
    
    
    func didTapVoiceRecButton() {
        coordinator?.showPlayer()
//
//        tabBarController?.tabBar.isHidden = true
//        navigationController?.navigationBar.isHidden = true
//
//        view.addSubview(blure)
//        view.addSubview(player)
//
//        NSLayoutConstraint.activate([
//            blure.topAnchor.constraint(equalTo: view.topAnchor),
//            blure.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            blure.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            blure.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//
//            player.topAnchor.constraint(equalTo: view.bottomAnchor),
//            player.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 30),
//            player.heightAnchor.constraint(equalToConstant: 570),
//            player.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
//            ])
//
//        UIView.animate(withDuration: 0.5, animations: {
//            self.player.transform = CGAffineTransform(translationX: 0, y: -600)
//            self.player.alpha = 1
//            self.blure.alpha = 1
//        })
    }
}
