//
//  ViewController.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 02.10.2024.
//

import UIKit
import SnapKit

class TodoTasksViewController: UIViewController {
    private var databaseManager: (any DatabaseManager)?
    private var todos: [TodoTaskProtocol] = []
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        databaseManager = CoreDataManager.shared
        fetchInitialTodos()
        setupTableHeaderView()
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
    
    private func setupTableHeaderView() {
        let headerView = TableHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        
        headerView.onAddButtonTapped = { [weak self] in
            self?.addNewTask()
        }
        
        tableView.tableHeaderView = headerView
    }
}

// MARK: - Methods for interacting with the db
extension TodoTasksViewController {
    private func addNewTask() {
        let modalVC = TaskModalViewController()
        
        modalVC.onSaveTask = { [weak self] taskName, date in
            let addedTodoTask = self?.databaseManager?.add(name: taskName, isDone: false, dueDate: date, subtasks: [])
            guard let addedTodoTask else { return }
            print("Added todo task: \n\(addedTodoTask)")
            self?.todos.append(addedTodoTask)
            self?.tableView.reloadData()
        }
        
        modalVC.modalPresentationStyle = .automatic
        present(modalVC, animated: true, completion: nil)
    }
    
    private func fetchInitialTodos() {
        todos = databaseManager?.getAllTodoTasks() ?? []
    }
}

// MARK: - TaskDoneProtocol conformance for setting task as done
extension TodoTasksViewController: TaskDoneProtocol {
    func taskDone(task: inout TodoTaskProtocol) {
        guard let databaseManager else { return }
        databaseManager.update(todoTask: &task)
    }
}

// MARK: - UITableViewDataSource
extension TodoTasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoCell = tableView.dequeueReusableCell(
            withIdentifier: TodoCellView.cellIdentifier,
            for: indexPath
        ) as! TodoCellView
        todoCell.delegate = self
        
        let todoTask = todos[indexPath.row]
        todoCell.todoTask = todoTask
        todoCell.configure()
        
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
extension TodoTasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoTask = todos[indexPath.row]
        let todoSubtasksViewController = TodoSubtasksViewController()
        todoSubtasksViewController.databaseManager = self.databaseManager
        todoSubtasksViewController.todoTask = todoTask
        self.navigationController?.pushViewController(todoSubtasksViewController, animated: true)
    }
}

#Preview {
    TodoTasksViewController()
}
