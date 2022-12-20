//
//  PostFavoritesViewModel.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 14.12.2022.
//

import Foundation
//
//final class PostFavoritesViewModel {
//    var onStateChanged: ((State) -> Void)?
//    
//    private(set) var state: State = .initial {
//        didSet {
//            onStateChanged?(state)
//        }
//    }
//
//    private(set) var posts: [Post] = []
//    private let coreDataService = CoreDataManager()
//    
//    func send(_ action: PostFavoritesViewModel.Action) {
//        switch action {
//        case .viewWillAppear:
//            state = .loading
//            fetchPosts()
//        case .deleted(let post):
//            coreDataService.delete(post: post)
//            state = .loading
//            fetchPosts()
//        }
//    }
//    
//    private func fetchPosts() {
//        let posts = coreDataService.read()
//        guard !posts.isEmpty else {
//            self.state = .empty
//            return
//        }
//        self.posts = posts
//        self.state = .loaded
//    }
//}
//
//extension PostFavoritesViewModel {
//    enum State {
//        case initial
//        case loading
//        case loaded
//        case empty
//    }
//    enum Action {
//        case viewWillAppear
//        case deleted(Post)
//    }
//}
//
