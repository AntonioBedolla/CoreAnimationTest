//
//  CoreDataManager.swift
//  CoreAnimationTest
//
//  Created by Antonio Bedolla on 31/01/25.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "TestModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error loadding CoreData: \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving Core Data: \(error)")
            }
        }
    }
    
    func fetchEntities<T: NSManagedObject>(_ entityType: T.Type) -> [T] {
        let request = NSFetchRequest<T>(entityName: String(describing: entityType))
        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch entities: \(error)")
            return []
        }
    }
}
