//
//  MainCollectionViewCell.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 26.12.2022.
//

import UIKit

protocol MainEditDelegate: AnyObject {
    func tapEditingInfo()
    func tapEditingStatusLife()
}
class MainTableViewCell: UITableViewCell {
    
    
    weak var delegate: MainEditDelegate?
    
    private lazy var lineUp: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor.createColor(light: .black, dark: .white)
        line.contentMode = .scaleAspectFill
        line.layer.cornerRadius = 3
        line.clipsToBounds = true
        return line
    }()
    
    private lazy var info: UILabel = {
        let name = UILabel()
        name.text = "О себе:"
        name.font = UIFont.systemFont(ofSize: 20.0, weight: .heavy)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    lazy var name: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    lazy var friends: UILabel = {
        let status = UILabel()
        status.font = UIFont.systemFont(ofSize: 12.0, weight: .light)
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .createColor(light: .black, dark: .white)
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .light)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var statusLife: UILabel = {
        let label = UILabel()
        label.textColor = .createColor(light: .black, dark: .white)
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var heightUser: UILabel = {
        let label = UILabel()
        label.textColor = .createColor(light: .black, dark: .white)
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var yearsUser: UILabel = {
        let label = UILabel()
        label.textColor = .createColor(light: .black, dark: .white)
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "pencil.circle"), for: .normal)
        button.addTarget(self, action: #selector(tapEdit), for: .touchUpInside)
        button.tintColor = UIColor.createColor(light: .black, dark: .white)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.menu = addMenuItems()
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func constraints() {
        [info, name, yearsUser, statusLife, heightUser, editButton, descriptionLabel].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            info.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            info.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            
            editButton.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
            editButton.heightAnchor.constraint(equalToConstant: 25),
            editButton.widthAnchor.constraint(equalToConstant: 25),
            
            name.topAnchor.constraint(equalTo: info.bottomAnchor,constant: 10),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            
            yearsUser.topAnchor.constraint(equalTo: name.bottomAnchor,constant: 10),
            yearsUser.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
        
            statusLife.topAnchor.constraint(equalTo: yearsUser.bottomAnchor,constant: 10),
            statusLife.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            
            heightUser.topAnchor.constraint(equalTo: statusLife.bottomAnchor,constant: 10),
            heightUser.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            
            descriptionLabel.topAnchor.constraint(equalTo: heightUser.bottomAnchor,constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20)
        ])
    }
    
    @objc func tapEdit() {
        delegate?.tapEditingInfo()
    }
    
    private func addMenuItems() -> UIMenu {
        let changeAvatarAction = UIAction(title: "Изменить ФИО",image: UIImage(systemName: "person.fill.viewfinder")) { _ in
            
        }
        let changeName = UIAction(title: "Изменить возраст",image: UIImage(systemName: "person.text.rectangle.fill")) { _ in
            
        }
        
        let changeStatus = UIAction(title: "Изменить cемейное положение", image: UIImage(systemName: "heart.text.square.fill")) { _ in
            self.delegate?.tapEditingStatusLife()
        }
        
        let changeDescription = UIAction(title: "Изменить привычки", image: UIImage(systemName: "heart.text.square.fill")) { _ in
        }
        let menu = UIMenu(title: "Выберите действие", children: [changeAvatarAction, changeName, changeStatus, changeDescription])
        return menu
    }
}
