//
//  FeedViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 21.08.2022.
//

import UIKit
import StorageService
import SnapKit

class FeedViewController: UIViewController {

    let model: FeedModel
    lazy var feedView = FeedView(delegate: self)

    init(model: FeedModel) {
        
        self.model = model
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

        feedView.snp.makeConstraints{
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

//MARK: - FeedViewDelegate
extension FeedViewController: FeedViewDelegate {

   func didTapPostButton() {
        let vc = PostViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    func check(word: String) {
        model.check(word: word)
    }
}
