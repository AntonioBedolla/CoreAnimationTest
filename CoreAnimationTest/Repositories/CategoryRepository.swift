//
//  CategoryRepository.swift
//  CoreAnimationTest
//
//  Created by Antonio Bedolla on 31/01/25.
//

import Foundation
import CoreData

class CategoryRepository: CategoryProtocol {
    
    private let coreDataManager = CoreDataManager.shared
    
    /// Fetches all categories from Core Data.
        func fetchCategories() -> [Category] {
            return coreDataManager.fetchEntities(Category.self)
        }

        /// Creates a new category in Core Data.
        func createCategory(name: String) {
            let newCategory = Category(context: coreDataManager.context)
            newCategory.name = name
            coreDataManager.saveContext()
        }

        /// Updates an existing category in Core Data.
        func updateCategory(_ category: Category, with name: String) {
            category.name = name
            coreDataManager.saveContext()
        }

        /// Deletes a category from Core Data.
        func deleteCategory(_ category: Category) {
            coreDataManager.context.delete(category)
            coreDataManager.saveContext()
        }

        /// Saves the Core Data context.
        func save() {
            coreDataManager.saveContext()
        }
    
    /*static let shared = CategoryRepository()
        private let context = CoreDataManager.shared.context

        // Crear una nueva categoría
        func addCategory(name: String) {
            let category = Category(context: context)
            category.name = name
            CoreDataManager.shared.saveContext()
        }

        // Obtener todas las categorías
        func fetchCategories() -> [Category] {
            let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
            do {
                return try context.fetch(fetchRequest)
            } catch {
                print("Error al obtener categorías: \(error)")
                return []
            }
        }

        // Eliminar una categoría
        func deleteCategory(_ category: Category) {
            context.delete(category)
            CoreDataManager.shared.saveContext()
        }*/
}
