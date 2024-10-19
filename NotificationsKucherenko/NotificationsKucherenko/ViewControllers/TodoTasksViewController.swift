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
    private var hideSecuredTodos = true
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        databaseManager = CoreDataManager.shared
        Task {
            await NotificationsManager.shared.requestPermission()
        }
        fetchInitialTodos()
        setupTableHeaderView()
        setupTableView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTodoAdded), name: NSNotification.Name("TodoAdded"), object: nil)
    }
    
    private func setupTableHeaderView() {
        navigationItem.title = "Todos"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
        let inboxButton = UIBarButtonItem(title: "Inbox", style: .plain, target: self, action: #selector(openInbox))
        let hideSecuredButton = UIBarButtonItem(image: UIImage(systemName: "eye.slash.fill"), style: .plain, target: self, action: #selector(toggleHideSecuredTodos))
            
        navigationItem.rightBarButtonItems = [addButton, hideSecuredButton]
        navigationItem.leftBarButtonItem = inboxButton
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func toggleHideSecuredTodos() {
        hideSecuredTodos.toggle()
        
        if let hideSecuredButton = navigationItem.rightBarButtonItems?.last {
            hideSecuredButton.image = hideSecuredTodos ? UIImage(systemName: "eye.slash.fill") : UIImage(systemName: "eye")
        }
        hideSecuredTodos ? fetchInitialTodos() : fetchAllTodos()
    }
    
    @objc private func openInbox() {
        let inboxVC = InboxTodosViewController()
        inboxVC.databaseManager = databaseManager
        
        self.navigationController?.pushViewController(inboxVC, animated: true)
    }
}

// MARK: - Methods for interacting with the db
private extension TodoTasksViewController {
    @objc func handleTodoAdded() {
        fetchInitialTodos()
    }
    
    @objc func addNewTask() {
        let modalVC = TaskModalViewController()
        
        modalVC.onSaveTask = { [weak self] taskName, date, isSecured in
            let addedTodoTask = self?.databaseManager?.add(name: taskName, isDone: false, dueDate: date, isSecured: isSecured)
            guard let addedTodoTask else { return }
            print("Added todo task: \n\(addedTodoTask)")
            self?.todos.append(addedTodoTask)
            
            Task {
                await NotificationsManager.shared.turnNotification(for: addedTodoTask.id, name: addedTodoTask.name ?? "", date: addedTodoTask.dueDate ?? Date())
            }
            self?.handleTodoAdded()
        }
        
        modalVC.modalPresentationStyle = .automatic
        present(modalVC, animated: true, completion: nil)
    }
    
    func fetchInitialTodos() {
        todos = databaseManager?.getInsecuredTodoTasks() ?? []
        tableView.reloadData()
    }
    
    func fetchAllTodos() {
        todos = databaseManager?.getAllTodoTasks() ?? []
        tableView.reloadData()
    }
}

// MARK: - TaskDoneProtocol conformance for setting task as done
extension TodoTasksViewController: TodoTaskDelegate {
    func taskDone(task: inout TodoTaskProtocol) {
        guard let databaseManager else { return }
        databaseManager.update(todoTask: &task)
    }
    
    func alarmSetting(task: inout TodoTaskProtocol) {
        guard let databaseManager else { return }
        databaseManager.updateAlarm(todoTask: &task)
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

extension TodoTasksViewController: UITableViewDelegate {}

#Preview {
    TodoTasksViewController()
}
