//
//  InfoViewController.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 21.08.2022.
//

import UIKit
import Foundation

class InfoViewController: UIViewController {

    lazy var infoView = InfoView(delegate: self)
    private var residents = [Resident]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        infoView.setTableView(dataSource: self, delegate: self)
        view.backgroundColor = .systemOrange
        title = "Info"

    }

    private func layout() {
        view.addSubview(infoView)

        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: view.topAnchor),
            infoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            infoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - FeedViewDelegate
extension InfoViewController: InfoViewDelegate {

    func didTapFirstTaskButton() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/47")
        firstTaskNetworkService.request(url: url) { title in
            self.infoView.setTextFirstTaskLabel(title)
        }
    }

    func didTapSecondTaskButton() {
        let url = URL(string: "https://swapi.dev/api/planets/1")
        secondTaskNetworkService.request(url: url) { planet in
            self.infoView.setTextSecondTaskLabel("Период обращения планеты \(planet.name) вокруг своей звезды = \(planet.orbitalPeriod)")
        }
    }

    func didTapThirdTaskButton() {
        let url = URL(string: "https://swapi.dev/api/planets/1")
        secondTaskNetworkService.request(url: url) { planet in
            self.getNamesOfResidents(residentsUrl: planet.residents)
        }
    }

    private func getNamesOfResidents(residentsUrl: [String]) {
        for url in residentsUrl {
            guard let url = URL(string: url) else { return }
            thirdTaskNetworkService.request(url: url) { resident in
                self.residents.append(resident)
                self.infoView.reloadData()
            }
        }
    }
}

extension InfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        residents.count
    }
}

extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        if indexPath.row <= residents.count - 1 {
            content.text = residents[indexPath.row].name
        }
        cell.contentConfiguration = content

        return cell
    }
}

// MARK: Task 1
struct firstTaskNetworkService {

    static func request(url: URL?, completion: @escaping (String) -> Void) {
        guard let url = url else { return }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        var jsonObject: [String: Any]!
        let task = session.dataTask(with: urlRequest) { data, response, error in
            print("\n---Data---")
            guard let data = data else { return }
            do {
                jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            } catch {
                print("data error")
            }
            let title = jsonObject["title"] as! String
            DispatchQueue.main.async {
                completion(title)
            }
            print(jsonObject as Any)
        }
        task.resume()
    }
}

// MARK: Task 2
struct secondTaskNetworkService {

    static func request(url: URL?, completion: @escaping (Planet) -> Void) {
        guard let url = url else { return }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        var planet: Planet?
        let task = session.dataTask(with: urlRequest) { data, response, error in
            print("\n---Response---")
            guard let httpResponse = response as? HTTPURLResponse else { return }
            print(httpResponse.statusCode)
            print("\n---Data---")
            guard let data = data else { return }
            do {
                planet = try JSONDecoder().decode(Planet.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
            guard let planet = planet else { return }
            DispatchQueue.main.async {
                completion(planet)
            }
            print(planet)
        }
        task.resume()
    }
}

struct Planet: Decodable {
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: String
    let residents: [String]
    let films: [String]
    let created: String
    let edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter
        case climate
        case gravity
        case terrain
        case surfaceWater = "surface_water"
        case population
        case residents
        case films
        case created
        case edited
        case url
    }
}

// MARK: Task 3
struct thirdTaskNetworkService {

    static func request(url: URL?, completion: @escaping (Resident) -> Void) {
        guard let url = url else { return }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        var resident: Resident?
        let task = session.dataTask(with: urlRequest) { data, response, error in
            print("\n---Response---")
            guard let httpResponse = response as? HTTPURLResponse else { return }
            print(httpResponse.statusCode)
            print("\n---Data---")
            guard let data = data else { return }
            do {
                resident = try JSONDecoder().decode(Resident.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
            guard let resident = resident else { return }
            DispatchQueue.main.async {
                completion(resident)
            }
            print(resident.name)
        }
        task.resume()
    }
}

struct Resident: Decodable {
    let name: String
}
