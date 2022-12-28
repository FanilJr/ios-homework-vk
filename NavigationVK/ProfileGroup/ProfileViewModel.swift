//
//  ProfileViewModel.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 14.12.2022.
//

import Foundation
import UIKit

final class ProfileViewModel {
    
    var onStateChanged: ((State) -> Void)?
    var showPhotosVc: (() -> Void)?
    var showLoginVc: (() -> Void)?
    var showPostVc: ((Post) -> Void)?
    var showImageSettingsVc: (() -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateChanged?(state)
        }
    }
    
    var posts = [Post]()
    var info = [InfoUser]()
    private let infoApi: InfoAPI = InfoAPI()
    private let postApi: PostAPI = PostAPI()
    
    private var timer: Timer?
    var reverseTime: Int = 10
    
    func send(_ action: Action) {
        switch action {
        case .viewIsReady:
            fetchPosts()
        case .showPhotosVc:
            showPhotosVc?()
        case .showLoginVc:
            showLoginVc?()
        case .showPostVc(let post):
            showPostVc?(post)
//        case .savePost(let post):
//            coreDataService.save(post: post)
        case .showImageSettingsVc:
            showImageSettingsVc?()
        }
    }
    
    private func fetch(post: [Post]) {
        posts = post
    }
    
    private func fetchPosts() {
        postApi.fetchPosts { [weak self] result in
            switch result {
            case .success(let posts):
                self?.posts = posts
                DispatchQueue.main.async {
                    self?.state = .loaded
                }
            case .failure(let error):
                switch error {
                case .emptydata:
                    DispatchQueue.main.async {
                        self?.state = .alertEmptyData(error)
                    }
                }
            }
        }
    }
    
    func createTimer() {
        if timer == nil {
            let timer = Timer.scheduledTimer(
                timeInterval: 1.0,
                target: self,
                selector: #selector(self.updateTimer),
                userInfo: nil,
                repeats: true
            )
            timer.tolerance = 0.1

            DispatchQueue.global(qos: .userInitiated).async {
                RunLoop.current.add(timer, forMode: .common)
                RunLoop.current.run()
            }
            self.timer = timer
        }
    }
    
    @objc
    func updateTimer() {
        if reverseTime > 0 {
            reverseTime -= 1
            DispatchQueue.main.async {
                
            }
        } else {
            reverseTime = 10
            cancelTimer()
            guard let post = posts.randomElement() else { return }
            posts.append(post)
            DispatchQueue.main.async {
                
            }
        }
    }
    
    func cancelTimer() {
      timer?.invalidate()
      timer = nil
    }
}

extension ProfileViewModel {
    
    enum Action {
        case viewIsReady
        case showPhotosVc
        case showLoginVc
        case showPostVc(Post)
//        case savePost(Post)
        case showImageSettingsVc
    }
    
    enum State {
        case initial
        case loaded
        case alertEmptyData(EmptyDataError)
    }
}
