//
//  ProfileViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 20.08.2022.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    private let userService: UserService
    private let userName: String
    private let header = ProfileHeaderView()
    private let profileImageView = ProfileImageView()
    private weak var coordinator: ProfileFlowCoordinator?
    var lastRowDisplay = 0
    private let cell = PhotosTableViewCell()
    
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
    
    /// Создаём свойства, которое принимает метод поста и свойство принимающее массив ячеек
    private let post = PostStruct.massivePost()
    private let numbersSection = [PostTableViewCell(), PhotosTableViewCell()]
    
    init(userService: UserService, userName: String, coordinator: ProfileFlowCoordinator) {
        self.userService = userService
        self.userName = userName
        self.coordinator = coordinator
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Профиль"

        setupTableView()
        header.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        loadUser(userName: userName)
        
    #if DEBUG
        background.image = UIImage(named: "background")
    #else
        background.image = UIImage(named: "background4")
    #endif

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func loadUser(userName: String) {
        userService.getUser(userName: userName) { result in
            switch result {
            case .success(let user):
                header.setupView(user: user)
            case .failure(let error):
                hundle(error: error)
            }
        }
    }
    
    private func hundle(error: UserGetError) {
        switch error{
        case .notFound: coordinator?.showAlert(title: "Ошибка", message: "ok")
        case .unowned: print("File:" + #file, "\nFunction: " + #function + "\nUserGetError.unowned\n")
        }
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
            return post.count
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
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
            cell.setupCell(post[indexPath.row])
            cell.backgroundColor = .white
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tuchUp() {
        print("tuch по кнопке delegate из ProfileViewController")
        coordinator?.showPhotos()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if lastRowDisplay > indexPath.row {
            cell.transform = CGAffineTransform(translationX: 0, y: -250)
        } else {
            cell.transform = CGAffineTransform(translationX: 0, y: 250)
        }

        lastRowDisplay = indexPath.row
        
        UIView.animate(withDuration: 0.5, animations: {
            cell.transform = CGAffineTransform.identity
        })
        
    }
}

extension ProfileViewController: UITableViewDelegate, MyClassDelegate, SettingsDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    func didTapLogoutButton() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            coordinator?.pop()
        } catch {
            print("Error signout")
        }
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

        profileImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: -245),
        profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
        profileImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
        profileImageView.heightAnchor.constraint(equalToConstant: 245),
       ])
       
       UIView.animate(withDuration: 0.5, animations: {
           self.header.avatarImageView.alpha = 0.0
           self.profileImageView.transform = CGAffineTransform(translationX: 0, y: 360)
           self.profileImageView.alpha = 1
           self.blure.alpha = 1
       })
       tabBarController?.tabBar.isHidden = true
    }
    func openSetting() {
        coordinator?.showSettings(title: "Настройки")
    }
    
    func tapClosed() {
        UIView.animate(withDuration: 0.5, animations: {
            self.header.avatarImageView.alpha = 1
            self.profileImageView.transform = CGAffineTransform(translationX: 0, y: -360)
            self.blure.alpha = 0
        })
        tabBarController?.tabBar.isHidden = false
// MARK: Надо доделать этот блок кода, с помощью Dispatch, пока не выполнится ^ этот блок, то этот не приступает - ГОТОВО.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            coordinator?.showPhotos()
        }
        
        if indexPath.section > 0 {
            let vc = ProfilePostViewController()
            vc.setupCell(post[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
//
//extension ProfileViewController: MyClassDelegate {
//    func didTapLogoutButton() {
//        do {
//            try FirebaseAuth.Auth.auth().signOut()
//            coordinator?.pop()
//        } catch {
//            print("Error signout")
//        }
//    }
//}

