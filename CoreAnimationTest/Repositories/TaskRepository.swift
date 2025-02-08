//
//  TaskRepository.swift
//  CoreAnimationTest
//
//  Created by Antonio Bedolla on 31/01/25.
//

import Foundation
import CoreData

class TaskRepository {
    
    static let shared = TaskRepository()
        private let context = CoreDataManager.shared.context

        // Crear una nueva tarea dentro de una categoría
        func addTask(to category: Category, title: String, isCompleted: Bool = false) {
            let task = Task(context: context)
            task.title = title
            task.isCompleted = isCompleted
            task.category = category
            CoreDataManager.shared.saveContext()
        }

        // Obtener todas las tareas de una categoría
        func fetchTasks(for category: Category) -> [Task] {
            return category.tasks?.allObjects as? [Task] ?? []
        }

        // Marcar una tarea como completada
        func updateTaskStatus(_ task: Task, isCompleted: Bool) {
            task.isCompleted = isCompleted
            CoreDataManager.shared.saveContext()
        }

        // Eliminar una tarea
        func deleteTask(_ task: Task) {
            context.delete(task)
            CoreDataManager.shared.saveContext()
        }
}
