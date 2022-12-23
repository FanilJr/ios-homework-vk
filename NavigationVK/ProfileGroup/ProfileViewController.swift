//
//  ProfileViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 20.08.2022.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    var tabBarItemOne: UITabBarItem = UITabBarItem()
//    private let post = PostStruct.massivePost()
    private var posts = PostAPI.getPosts()
    private let photos = PhotosAPI.getPhotos()
    private let viewModel: ProfileViewModel
    private var service: UserService
    private var fullName: String
    private let mapView = MapView()
    private let like = LikeView()
    private let numbersSection = [PostTableViewCell(), PhotosTableViewCell()]
    private let header = ProfileHeaderView()
    private let profileImageView = ProfileImageView()
    
    private let cell = PhotosTableViewCell()
    private let profilePost = ProfilePostViewController()
    var lastRowDisplay = 0
    private var cellIndex = 0
    
    var blure: UIVisualEffectView = {
        let bluereEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blure = UIVisualEffectView()
        blure.effect = bluereEffect
        blure.translatesAutoresizingMaskIntoConstraints = false
        blure.clipsToBounds = true
        blure.alpha = 0
        return blure
    }()
    
    let background: UIImageView = {
        let back = UIImageView()
        back.image = UIImage(named: "tekstura")
        back.clipsToBounds = true
        back.translatesAutoresizingMaskIntoConstraints = false
        return back
    }()
    
    /// ВАЖНО!!! задал .insetGroup, чтобы корнер радиус применился к всем ячейкам автоматически, но при этом нельзя применить конкретно к тейбл вью корнер радиус, если поставить .grouped, тогда можно для тейбл вью поставить cornerRadius и задать конкретно к ячейкам например "if indexPath.row == 0 maskedCorner" и не забыть вернуть констрейнты с отступами лево и право тейбл вью
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        return tableView
    }()
    
    init(viewModel: ProfileViewModel, service: UserService, fullName: String) {
        self.viewModel = viewModel
        self.service = service
        self.fullName = fullName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tabBarController?.tabBar.isHidden = false
        viewModel.send(.viewIsReady)
        configureProfileHeaderView()
        configureProfileImageView()
        
        title = "profile.title".localized
        
        setupTableView()
        header.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let tabbarControllerItems = self.tabBarController?.tabBar.items
        if let arrayOfTabBatItems = tabbarControllerItems! as AnyObject as? NSArray {
            tabBarItemOne = arrayOfTabBatItems[1] as! UITabBarItem
            if tabBarController?.tabBar.selectedItem == tabBarItemOne {
                print("Это тап на профиль")
            } else {
            }
        }
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func configureProfileHeaderView() {
        do {
            let user = try service.getUser(fullName: fullName)
            header.configure(with: user)
        } catch let error as UserNotFoundError {
            showAlertUserNotFound(with: error)
        } catch {
            print("Counldn't create the user")
        }
    }
    
    private func configureProfileImageView() {
        do {
            let user = try service.getUser(fullName: fullName)
            profileImageView.configure(with: user)
        } catch let error as UserNotFoundError {
            showAlertUserNotFound(with: error)
        } catch {
            print("Counldn't create the user")
        }
    }
    
    
    
    private func setupViewModel() {
        viewModel.onStateChanged = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .initial:
                print("initial")
            case .loaded:
                self.tableView.reloadData()
                self.viewModel.createTimer()
            case .alertEmptyData(let error):
                self.showAlertEmptyPosts(with: error)
            }
        }
    }
    
    @objc func signOutTapped() {
        viewModel.send(.showLoginVc)
    }
            
    func setupTableView() {
            
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        [background, tableView].forEach({ view.addSubview($0) })
            
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leftAnchor.constraint(equalTo: view.leftAnchor),
            background.rightAnchor.constraint(equalTo: view.rightAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension ProfileViewController: UITableViewDataSource, MyClassDelegateTwo {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return numbersSection.count
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
        switch section {
        case 0:
            return 1
        case 1:
            return viewModel.posts.count
        default:
            return 0
        }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        switch indexPath.section {
                
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as! PhotosTableViewCell
            cell.tuchNew = self
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.backgroundColor = .createColor(light: .white, dark: .systemGray5)
            return cell
                
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
            cell.backgroundColor = .createColor(light: .white, dark: .systemGray5)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none

            let tapRecog = UITapGestureRecognizer(target: self, action: #selector(duobleTapInPost))
            tapRecog.numberOfTapsRequired = 2
            let currentPost: Post = viewModel.posts[indexPath.row]
            cell.addGestureRecognizer(tapRecog)
            cell.configure(with: currentPost)
            cell.name.text = header.fullNameLabel.text
            cell.avatarImageView.image = header.avatarImageView.image
            cell.status.text = "Разработчик"
            return cell

            
        default:
            return UITableViewCell()
        }
    }
        
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {

        let recipe = viewModel.posts[indexPath.row]
        let recipeAuthor = viewModel.posts[indexPath.row].author
        let recipeImage = viewModel.posts[indexPath.row].image

        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { _ in

            let pushPost = UIAction(title: "profile.go.post".localized, image: UIImage(systemName: "chevron.right.circle")) { _ in
                //MARK: PUSH COORDINATOR
//                   self.coordinator?.showPost(post: (self.viewModel.posts[indexPath.row])!)
//                   self.viewModel.send(.showPost(self.posts![indexPath.row]))
                //MARK: Работает НООООО
//                   self.viewModel.send(.showPostVc((self.posts?[indexPath.row])!))
                let profilePost = ProfilePostViewController()
                profilePost.setupCell(recipe)
                self.navigationController?.pushViewController(profilePost, animated: true)
//                   self.viewModel.send(.showPostVc(recipe))
                //MARK: PUSH NavigationController
                //                self.profilePost.setupCell(self.posts[indexPath.row])
                //                self.navigationController?.pushViewController(self.profilePost, animated: true)
            }

            let share = UIAction(title: "profile.shared".localized, image: UIImage(systemName: "square.and.arrow.up")) { _ in

                let avc = UIActivityViewController(activityItems: [recipeAuthor as Any, UIImage(named: recipeImage) as Any], applicationActivities: nil)
                self.present(avc, animated: true)
            }
            let menu = UIMenu(title: "", children: [pushPost, share])
            return menu
        })
        return configuration
    }
    
    func tuchUp() {
        print("tuch по кнопке delegate из ProfileViewController")
        viewModel.send(.showPhotosVc)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            viewModel.send(.showPhotosVc)
        }
        if indexPath.section > 0 {
            self.cellIndex = indexPath.row
        }
        if indexPath.section == 2 {
            let doubleTap = UITapGestureRecognizer(target: self, action: #selector(duobleTapInPost))
            doubleTap.numberOfTapsRequired = 2
            tableView.addGestureRecognizer(doubleTap)
        }
    }
}
    
extension ProfileViewController: UITableViewDelegate, MyClassDelegate, SettingsDelegate {

    func exitAcc() {
        print("Выход из аккаунта")
        viewModel.send(.showLoginVc)
        
    }
    
    func didTapLogoutButton() {
        print("heooollala")
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
        
    func presentMenuAvatar() {
            
        view.addSubview(blure)
        view.addSubview(profileImageView)
        profileImageView.avatarImageView.image = UIImage(named: "1")
        profileImageView.settingDelegate = self
            
        NSLayoutConstraint.activate([
            blure.topAnchor.constraint(equalTo: view.topAnchor),
            blure.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blure.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blure.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
            profileImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: -720),
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            profileImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            profileImageView.heightAnchor.constraint(equalToConstant: 720),
        ])
        
        UIView.animate(withDuration: 0.8, animations: {
            self.header.avatarImageView.alpha = 0.0
            self.profileImageView.transform = CGAffineTransform(translationX: 0, y: 830)
            self.profileImageView.alpha = 1
            self.blure.alpha = 1
        })
        tabBarController?.tabBar.isHidden = true
    }
    
    func openSetting() {
        viewModel.send(.showImageSettingsVc)
    }
    
    func tapClosed() {
        UIView.animate(withDuration: 0.8, animations: {
            self.header.avatarImageView.alpha = 1
            self.profileImageView.transform = CGAffineTransform(translationX: 0, y: -830)
            self.blure.alpha = 0
        })
        tabBarController?.tabBar.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.profileImageView.removeFromSuperview()
            self.blure.removeFromSuperview()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    
        switch section {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return 0
        default:
            return 0
        }
    }
}
    
extension ProfileViewController {
        
        private func showAlertEmptyPosts(with error: EmptyDataError) {
            CommonAlertError.present(vc: self, with: error)
        }
        
        private func showAlertUserNotFound(with error: UserNotFoundError) {
            CommonAlertError.present(vc: self, with: error)
        }
    }

extension ProfileViewController {
    @objc private func duobleTapInPost() {
        guard let post = posts?[self.cellIndex] else { return }
        print(post)
        var isContains = false
        self.view.addSubview(self.like)
        NSLayoutConstraint.activate([
            self.like.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.like.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.like.heightAnchor.constraint(equalToConstant: 200),
            self.like.widthAnchor.constraint(equalToConstant: 200)
        ])
        UIView.animate(withDuration: 0.7) {
            self.like.alpha = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1.1) {
            UIView.animate(withDuration: 1) {
                self.like.alpha = 0
            }
        }
        for i in CoreDataManager.shared.favoritePost {
            if i.id == post.id {
                isContains = true
            }
        }
        
        if !isContains {
            CoreDataManager.shared.saveToCoreData(post: post)
        } else {
            print("error contains")
        }
    }
}
        
    


