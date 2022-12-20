//
//  InfoView.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 14.10.2022.
//

import UIKit

protocol InfoViewDelegate: AnyObject {
    func didTapFirstTaskButton()
    func didTapSecondTaskButton()
    func didTapThirdTaskButton()
}

//class InfoView: UIView {
//
//    weak var delegate: InfoViewDelegate?
//
//    private let scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        return scrollView
//    }()
//
//    private let contentView: UIView = {
//        let contentView = UIView()
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        return contentView
//    }()
//
//    let firstTaskButton = CustomButton(title: "Первая Задача", titleColor: .white, backgroundColor: .systemCyan, setBackgroundImage: UIImage(named: "blue_pixel") ?? UIImage())
//    let secondTaskButton = CustomButton(title: "Вторая задача", titleColor: .white, backgroundColor: .systemCyan, setBackgroundImage: UIImage(named: "blue_pixel") ?? UIImage())
//    let thirdTaskButton = CustomButton(title: "Третья задача", titleColor: .white, backgroundColor: .systemCyan, setBackgroundImage: UIImage(named: "blue_pixel") ?? UIImage())
//
//
//    private let firstTaskLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Поле для вывода результата первой задачи"
//        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let secondTaskLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Поле для вывода результата второй задачи"
//        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let thirdTaskLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Результат третей задачи в tableView"
//        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let spinnerViewFirst: UIActivityIndicatorView = {
//        let activityView: UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
//        activityView.hidesWhenStopped = true
//        activityView.translatesAutoresizingMaskIntoConstraints = false
//        return activityView
//    }()
//
//    private let spinnerViewSecond: UIActivityIndicatorView = {
//        let activityView: UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
//        activityView.hidesWhenStopped = true
//        activityView.translatesAutoresizingMaskIntoConstraints = false
//        return activityView
//    }()
//
//    private let spinnerViewThree: UIActivityIndicatorView = {
//        let activityView: UIActivityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
//        activityView.hidesWhenStopped = true
//        activityView.translatesAutoresizingMaskIntoConstraints = false
//        return activityView
//    }()
//
//    private let tableView: UITableView = {
//        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.backgroundColor = .clear
//        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
//        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
//        return tableView
//    }()
//
//    init(delegate: InfoViewDelegate?) {
//        super.init(frame: CGRect.zero)
//
//        translatesAutoresizingMaskIntoConstraints = false
//        self.delegate = delegate
//        backgroundColor = .white
//        layout()
//        taps()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func taps() {
//        firstTaskButton.tapAction = { [weak self] in
//            self?.delegate?.didTapFirstTaskButton()
//            self?.firstTaskButton.setTitle("", for: .normal)
//            self?.waitingSpinnerEnableFirst(true)
//        }
//        secondTaskButton.tapAction = { [weak self] in
//            self?.delegate?.didTapSecondTaskButton()
//            self?.secondTaskButton.setTitle("", for: .normal)
//            self?.waitingSpinnerEnableSecond(true)
//        }
//        thirdTaskButton.tapAction = { [weak self] in
//            self?.delegate?.didTapThirdTaskButton()
//            self?.thirdTaskButton.setTitle("", for: .normal)
//            self?.waitingSpinnerEnableThree(true)
//        }
//    }
//
//    func setTableView(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
//        tableView.dataSource = dataSource
//        tableView.delegate = delegate
//    }
//
//    func reloadData() {
//        tableView.reloadData()
//    }
//
//    func setTextFirstTaskLabel(_ text: String) {
//        firstTaskLabel.text = text
//    }
//    func setTextSecondTaskLabel(_ text: String) {
//        secondTaskLabel.text = text
//    }
//    func setTextThirdTaskLabel(_ text: String) {
//        thirdTaskLabel.text = text
//    }
//    func waitingSpinnerEnableThree(_ active: Bool) {
//        if active {
//            spinnerViewThree.startAnimating()
//        } else {
//            spinnerViewThree.stopAnimating()
//        }
//    }
//
//    func waitingSpinnerEnableSecond(_ active: Bool) {
//        if active {
//            spinnerViewSecond.startAnimating()
//        } else {
//            spinnerViewSecond.stopAnimating()
//        }
//    }
//    func waitingSpinnerEnableFirst(_ active: Bool) {
//        if active {
//            spinnerViewFirst.startAnimating()
//        } else {
//            spinnerViewFirst.stopAnimating()
//        }
//    }
//
//    private func layout() {
//
//        [firstTaskLabel, firstTaskButton, secondTaskLabel, secondTaskButton, thirdTaskLabel, thirdTaskButton, tableView, spinnerViewFirst, spinnerViewSecond, spinnerViewThree].forEach { contentView.addSubview($0) }
//        scrollView.addSubview(contentView)
//        addSubview(scrollView)
//
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: topAnchor),
//            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
//
//            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
//
//            firstTaskLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 30),
//            firstTaskLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 30),
//            firstTaskLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30),
//
//            firstTaskButton.topAnchor.constraint(equalTo: firstTaskLabel.bottomAnchor,constant: 30),
//            firstTaskButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 30),
//            firstTaskButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30),
//            firstTaskButton.heightAnchor.constraint(equalToConstant: 50),
//
//            spinnerViewFirst.centerXAnchor.constraint(equalTo: firstTaskButton.centerXAnchor),
//            spinnerViewFirst.centerYAnchor.constraint(equalTo: firstTaskButton.centerYAnchor),
//
//            secondTaskLabel.topAnchor.constraint(equalTo: firstTaskButton.bottomAnchor,constant: 30),
//            secondTaskLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 30),
//            secondTaskLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30),
//
//            secondTaskButton.topAnchor.constraint(equalTo: secondTaskLabel.bottomAnchor,constant: 30),
//            secondTaskButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 30),
//            secondTaskButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30),
//            secondTaskButton.heightAnchor.constraint(equalToConstant: 50),
//
//            spinnerViewSecond.centerYAnchor.constraint(equalTo: secondTaskButton.centerYAnchor),
//            spinnerViewSecond.centerXAnchor.constraint(equalTo: secondTaskButton.centerXAnchor),
//
//            thirdTaskLabel.topAnchor.constraint(equalTo: secondTaskButton.bottomAnchor,constant: 30),
//            thirdTaskLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 30),
//            thirdTaskLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30),
//
//            thirdTaskButton.topAnchor.constraint(equalTo: thirdTaskLabel.bottomAnchor,constant: 30),
//            thirdTaskButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 30),
//            thirdTaskButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30),
//            thirdTaskButton.heightAnchor.constraint(equalToConstant: 50),
//
//            spinnerViewThree.centerXAnchor.constraint(equalTo: thirdTaskButton.centerXAnchor),
//            spinnerViewThree.centerYAnchor.constraint(equalTo: thirdTaskButton.centerYAnchor),
//
//            tableView.topAnchor.constraint(equalTo: thirdTaskButton.bottomAnchor,constant: 30),
//            tableView.leadingAnchor.constraint(equalTo: firstTaskLabel.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: firstTaskLabel.trailingAnchor),
//            tableView.heightAnchor.constraint(equalToConstant: 250),
//            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//    }
//}
