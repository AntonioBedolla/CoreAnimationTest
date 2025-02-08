//
//  TasksViewController.swift
//  CoreAnimationTest
//
//  Created by Antonio Bedolla on 31/01/25.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    var category: Category
    var tasks: [Task] = []

    init(category: Category) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchTasks()
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func fetchTasks() {
        tasks = TaskRepository.shared.fetchTasks(for: category)
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        cell.backgroundColor = task.isCompleted ? UIColor.green.withAlphaComponent(0.5) : UIColor.white
        return cell
    }

    // MARK: - Animación de Entrada
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateTableView()
    }

    func animateTableView() {
        tableView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.tableView.alpha = 1
        }
    }
}
