//
//  TodoSubtasksViewController.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 08.10.2024.
//

import UIKit

class TodoSubtasksViewController: UIViewController {
    private var databaseManager: (any DatabaseManager)?
    private var todoSubtasks: [TodoSubtaskProtocol] = []
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
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
        headerView.setTableTitle("Todo Subtasks")
        
        headerView.onAddButtonTapped = { [weak self] in
//            self?.addNewTask()
        }
        
        tableView.tableHeaderView = headerView
    }
    
//    private func addNewTask() {
//        
//        let modalVC = TaskModalViewController()
//        
//        modalVC.onSaveTask = { [weak self] taskName, date in
//            let addedTodoTask = self?.databaseManager?.add(name: taskName, isDone: false, dueDate: date)
//            guard let addedTodoTask else { return }
//            print("Added todo task: \n\(addedTodoTask)")
//            self?.todos.append(addedTodoTask)
//            self?.tableView.reloadData()
//        }
//        
//        modalVC.modalPresentationStyle = .automatic
//        present(modalVC, animated: true, completion: nil)
//    }
}

extension TodoSubtasksViewController: SubtaskDoneProtocol {
    func subtaskDone(subtask: inout TodoSubtaskProtocol) {
        guard let databaseManager else { return }
//        databaseManager.update(todoTask: &task)
    }
}

// MARK: - UITableViewDataSource
extension TodoSubtasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoSubtasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoCell = tableView.dequeueReusableCell(
            withIdentifier: TodoSubtaskCellView.cellIdentifier,
            for: indexPath
        ) as! TodoSubtaskCellView
//        todoCell.delegate = self
        
        let todoSubTask = todoSubtasks[indexPath.row]
        todoCell.todoSubtask = todoSubTask
        todoCell.configure()
        
        return todoCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            let isTaskDeleted = databaseManager?.delete()
            todoSubtasks.remove(at: indexPath.row)
//            print("Task deleted: \(isTaskDeleted)")
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

// MARK: - UITableViewDelegate
extension TodoSubtasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

#Preview {
    TodoTasksViewController()
}
