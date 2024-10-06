//
//  ViewController.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 02.10.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private var databaseManager: (any DatabaseManager)?
    private var todos: [TodoTaskProtocol] = []
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()   
        databaseManager = RealmDataManager.shared
        fetchInitialTodos()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TodoCellView.self, forCellReuseIdentifier: TodoCellView.cellIdentifier)
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func fetchInitialTodos() {
        guard let databaseManager else { return }
        todos = databaseManager.getAllTodoTasks()
    }
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoCell = tableView.dequeueReusableCell(withIdentifier: TodoCellView.cellIdentifier, for: indexPath) as! TodoCellView
        let todoTask = todos[indexPath.row]
        todoCell.configure(with: todoTask)
        
        return todoCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let isTaskDeleted = databaseManager?.delete(todoTask: todos[indexPath.row])
            todos.remove(at: indexPath.row)
            print("Task deleted: \(isTaskDeleted)")
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

#Preview {
    ViewController()
}
