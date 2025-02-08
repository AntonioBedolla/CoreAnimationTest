//
//  EditCategoryViewController.swift
//  CoreAnimationTest
//
//  Created by Antonio Bedolla on 01/02/25.
//

import Foundation
import UIKit

class AddEditCategoryViewController: UIViewController {
    weak var delegate: CategoryUpdateDelegate?

        var category: Category? // The category being edited (nil for new categories)

        private let nameTextField = UITextField()
        private let saveButton = UIButton(type: .system)
        private let categoryRepository = CategoryRepository()

        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            populateFieldsIfEditing()
        }

        /// Sets up the UI elements, constraints, and styles.
        private func setupUI() {
            view.backgroundColor = .white

            // TextField setup
            nameTextField.placeholder = "Enter category name"
            nameTextField.borderStyle = .roundedRect
            nameTextField.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(nameTextField)

            // Save Button setup
            saveButton.setTitle("Save", for: .normal)
            saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
            saveButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(saveButton)

            // Constraints
            NSLayoutConstraint.activate([
                nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

                saveButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
                saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }

        /// Populates the text field if editing an existing category.
        private func populateFieldsIfEditing() {
            if let category = category {
                nameTextField.text = category.name
            }
        }

        /// Handles the save button tap to create or update a category.
        @objc private func saveButtonTapped() {
            guard let name = nameTextField.text, !name.isEmpty else {
                // Show an alert if the name is empty
                let alert = UIAlertController(title: "Error", message: "Category name cannot be empty.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
                return
            }

            if let category = category {
                // Update existing category
                categoryRepository.updateCategory(category, with: name)
            } else {
                // Create new category
                categoryRepository.createCategory(name: name)
            }

            delegate?.didUpdateCategoryList()
            navigationController?.popViewController(animated: true)
        }
}
