//
//  CategoryProtocol.swift
//  CoreAnimationTest
//
//  Created by Antonio Bedolla on 01/02/25.
//

import Foundation

protocol CategoryProtocol {
    func fetchCategories() -> [Category]
    func createCategory(name: String)
    func updateCategory(_ category: Category, with name: String)
    func deleteCategory(_ category: Category)
    func save()
}
