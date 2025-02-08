//
//  CategoriesViewController.swift
//  CoreAnimationTest
//
//  Created by Antonio Bedolla on 31/01/25.
//

import UIKit

class CategoriesViewController: UIViewController {

    private let tableView = UITableView()
    private let addButton = UIButton(type: .system)
    private let categoryRepository = CategoryRepository() // Handles Core Data operations
    private var categories: [Category] = [] // Stores fetched categories

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        fetchCategories()
    }

    func setupNavigationBar() {
        title = "Categorías"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "← Volver",
            style: .plain,
            target: self,
            action: #selector(dismissViewController)
        )
    }

    private func setupUI() {
            title = "Categories"
            view.backgroundColor = .white

            // TableView setup
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")
            tableView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(tableView)

            // Add Button setup
            addButton.setImage(UIImage(systemName: "plus"), for: .normal)
            addButton.tintColor = .white
            addButton.backgroundColor = .systemBlue
            addButton.layer.cornerRadius = 30
            addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            addButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(addButton)

            // Constraints
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

                addButton.widthAnchor.constraint(equalToConstant: 60),
                addButton.heightAnchor.constraint(equalToConstant: 60),
                addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            ])
        }

    @objc func dismissViewController() {
        navigationController?.popViewController(animated: true)
    }

    @objc func addCategory() {
        let addEditVC = AddEditCategoryViewController()
                addEditVC.delegate = self
                navigationController?.pushViewController(addEditVC, animated: true)
    }

    func fetchCategories() {
        categories = categoryRepository.fetchCategories()
        tableView.reloadData()
    }
    
    /// Handles the add button tap to create a new category.
        @objc private func addButtonTapped() {
            let addEditVC = AddEditCategoryViewController()
            addEditVC.delegate = self
            navigationController?.pushViewController(addEditVC, animated: true)
        }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCategory = categories[indexPath.row]
        let addEditVC = AddEditCategoryViewController()
        addEditVC.category = selectedCategory
        addEditVC.delegate = self
        navigationController?.pushViewController(addEditVC, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let categoryToDelete = categories[indexPath.row]
            categoryRepository.deleteCategory(categoryToDelete)
            categories.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - CategoryUpdateDelegate
extension CategoriesViewController: CategoryUpdateDelegate {

    func didUpdateCategoryList() {
        fetchCategories()
    }
}
