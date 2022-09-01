//
//  ProfileViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 20.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    private let userService: UserService
    private let userName: String
    private weak var coordinator: ProfileFlowCoordinator?
    var lastRowDisplay = 0
    
    let background: UIImageView = {
        
        let back = UIImageView()
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
        
        setupTableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        #if DEBUG
        background.image = UIImage(named: "background")
        #else
        background.image = UIImage(named: "background4")
        #endif

        print("как работает DidLoad")
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        print("как работает WillAppear")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("как работает DidAppear")

    }
   
    func setupTableView() {
        
        [background, tableView].forEach({ view.addSubview($0) })
        
        NSLayoutConstraint.activate([
        background.topAnchor.constraint(equalTo: view.topAnchor),
        background.leftAnchor.constraint(equalTo: view.leftAnchor),
        background.rightAnchor.constraint(equalTo: view.rightAnchor),
        background.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        tableView.topAnchor.constraint(equalTo: view.topAnchor),
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}

//    MARK: - Расширение UITableViewDataSource

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
        
        let photosController = PhotosViewController()
        navigationController?.pushViewController(photosController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // MARK: Анимация
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


//    MARK: - Расширение UITableViewDelegate

extension ProfileViewController: UITableViewDelegate, MyClassDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let PHView = ProfileHeaderView()
        PHView.delegate = self
        PHView.setupView(user: userService.getUser(userName: userName))
        
        switch section {
            
        case 0:
            return PHView
            
        case 1:
            return nil
            
        default:
            return UIView()
            
        }
    }

   func didtap() {

       let alert = UIAlertController(title: "Ты сломал аватарку", message: "Больше так не делай", preferredStyle: .alert)
       alert.addAction(UIAlertAction(title: "Восстановить", style: .default, handler: { _ in self.tableView.reloadData()
           print("перезагрузка аватарки")
       }))
       alert.addAction(UIAlertAction(title: "Закрыть", style: .destructive, handler: nil))
       
       self.present(alert, animated: true, completion: nil)
       
       print("нажатие в ProfileViewController - delegate")

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
    }
}


