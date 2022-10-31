//
//  CoreDataManager.swift
//  NavigationVK
//
//  Created by Fanil_Jr on 27.10.2022.
//


import Foundation
import UIKit
import CoreData

final class CoreDataManager {

    static let shared = CoreDataManager()
    public var favoritePost = [PostData]()

    //сохранение поста
    public func saveToCoreData(post: PostStruct) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext

            guard let entityDescription = NSEntityDescription.entity(forEntityName: "PostData", in: context) else { return }

            let newValue = NSManagedObject(entity: entityDescription, insertInto: context)
            let image = UIImage(named: post.image)
            let imageData = image?.pngData()

            newValue.setValue(imageData, forKey: "imageCell")
            newValue.setValue(post.author, forKey: "authorCell")
            newValue.setValue(post.description, forKey: "descriptionCell")
            newValue.setValue(post.likes, forKey: "likesCell")
            newValue.setValue(post.views, forKey: "viewsCell")
            newValue.setValue(post.id, forKey: "id")

            do {
                try context.save()
                print("\(post.author) saved")
            } catch {
                print("error saving")
            }
        }
    }

    //извлечение данных
    public func outFromCoreData() {
        favoritePost.removeAll()

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext

            let fetchRequest = NSFetchRequest<PostData>(entityName: "PostData")

            do {
                let results = try context.fetch(fetchRequest)

                for result in results {
                    favoritePost.append(result)
                }
            } catch {
                print("error out from CoreData")
            }
        }
    }

    //метод удаления
    public func removeFromCoreData() {

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchReauest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "PostData")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchReauest)

            do {
                try context.execute(deleteRequest)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
}
