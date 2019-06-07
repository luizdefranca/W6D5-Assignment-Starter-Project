//
//  mealStorgeManage.swift
//  w6d5-ui-performance-testing
//
//  Created by Luiz on 6/7/19.
//  Copyright © 2019 Roland. All rights reserved.
//

import UIKit
import CoreData
public class MealStorgeManager {

    let persistentContainer: NSPersistentContainer!
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    //MARK: Init with dependency
    init(container: NSPersistentContainer) {
        self.persistentContainer = container
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }

    convenience init() {
        //Use the default container for production environment

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not get shared app delegate")
        }
        self.init(container: appDelegate.persistentContainer)
    }

    //MARK: CRUD
    func insertmealItem( name: String, calories: Int64 ) -> Meal? {

        guard let meal = NSEntityDescription.insertNewObject(forEntityName: "Meal", into: backgroundContext) as? Meal else { return nil }
        meal.name = name
        meal.calories = calories

        return meal
    }

    func fetchAll() -> [Meal] {
        let request: NSFetchRequest<Meal> = Meal.fetchRequest()
        let results = try? persistentContainer.viewContext.fetch(request)
        return results ?? [Meal]()
    }

    func remove( objectID: NSManagedObjectID ) {
        let obj = backgroundContext.object(with: objectID)
        backgroundContext.delete(obj)
    }

    func save() {
        if backgroundContext.hasChanges {
            do {
                try backgroundContext.save()
            } catch {
                print("Save error \(error)")
            }
        }

    }
}
