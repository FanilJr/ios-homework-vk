//
//  RealmService.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 14.12.2022.
//

import Foundation
//import RealmSwift
//
//final class RealmService: AuthService {
//    private let ud = UserDefaults.standard
//
//    func login(email: String, password: String, completion: @escaping Handler) {
//        do {
//            let realm = try Realm()
//
//            let credentials: Results<Credentials> = { realm.objects(Credentials.self) }()
//            guard let credential = credentials.filter({ $0.email == email }).first else {
//                createUser(email: email, password: password, completion: completion)
//                return
//            }
//
//            signIn(email: credential.email, password: credential.password, completion: completion)
//            let userInfo = ["email": credential.email, "password": credential.password]
//            ud.set(userInfo, forKey: "login_user")
//        } catch let error {
//            print("Unable to get credentials \(error.localizedDescription)")
//        }
//    }
//
//    func createUser(email: String, password: String, completion: @escaping Handler) {
//        let newCredentials = Credentials()
//        newCredentials.email = email
//        newCredentials.password = password
//
//        do {
//            let realm = try Realm()
//
//            let block: () -> Void = {
//                realm.add(newCredentials)
//            }
//
//            if realm.isInWriteTransaction {
//                block()
//            } else {
//                try realm.write({
//                    block()
//                })
//            }
//
//        } catch let error {
//            print("Failed to write \(error.localizedDescription)")
//        }
//
//        completion(.success("\(String(describing: email)) created"))
//    }
//
//    func signIn(email: String, password: String, completion: @escaping Handler) {
//        let userInfo = ["email": email, "password": password]
//        ud.set(userInfo, forKey: "login_user")
//        completion(.success("Login was \(String(describing: email))"))
//    }
//
//    func signOut() {
//        ud.removeObject(forKey: "login_user")
//        print("Delete user from UserDefaults")
//
//        do {
//            let realm = try Realm()
//
//            let block: () -> Void = {
//                realm.delete(realm.objects(Credentials.self))
//            }
//
//            if realm.isInWriteTransaction {
//                block()
//            } else {
//                try realm.write({
//                    block()
//                })
//            }
//        } catch let error {
//            print("Failed to delete \(error.localizedDescription)")
//        }
//    }
//}
