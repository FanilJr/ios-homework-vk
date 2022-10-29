//
//  NetworkService.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 07.10.2022.
//

import Foundation

enum AppConfiguration: String, CaseIterable {
    case firstUrl = "https://swapi.dev/api/planets/8"
    case secondUrl = "https://swapi.dev/api/planets/3"
    case thirdUrl = "https://swapi.dev/api/planets/5"
    
    func getUrl() -> URL {
        switch self {
        case .firstUrl:
            return URL(string: self.rawValue)!
        case .secondUrl:
            return URL(string: self.rawValue)!
        case .thirdUrl:
            return URL(string: self.rawValue)!
        }
    }
}

struct NetworkService {
    
    static func request(for configuration: AppConfiguration) {
        let url = configuration.getUrl()
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            print("\n---Error---")
            print(error?.localizedDescription)
            print("\n---Response---")
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode = \(httpResponse.statusCode)")
                print("allHeaderFields = \(httpResponse.allHeaderFields)")
            }
            
            print("\n---Data")
            guard let data = data else { return }
            let jsonObject = try? JSONSerialization.jsonObject(with: data)
            guard let jsonObject = jsonObject else { return }
            print(jsonObject)
        }
        task.resume()
    }
}
