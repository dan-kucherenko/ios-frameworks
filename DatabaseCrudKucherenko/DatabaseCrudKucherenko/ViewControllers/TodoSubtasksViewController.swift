//
//  TodoSubtasksViewController.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 08.10.2024.
//

import UIKit

class TodoSubtasksViewController: UIViewController {
    private var todoSubtasks: [TodoSubtaskProtocol] = []
    var todoTask: TodoTaskProtocol?
    var databaseManager: (any DatabaseManager)?
    
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
//        let modalVC = SubtaskModalViewController()
//        
//        modalVC.onSaveTask = { [weak self] taskName in
//            guard let todoTask else { return }
//            let addedSubtask = self?.databaseManager?.add(subtaskName: taskName, to: todoTask)
//            
//            guard let addedSubtask else { return }
//            self?.todoSubtasks.append(addedSubtask)
//            self?.tableView.reloadData()
//        }
//        
//        modalVC.modalPresentationStyle = .automatic
//        present(modalVC, animated: true, completion: nil)
//    }
}

extension TodoSubtasksViewController: SubtaskDoneProtocol {
    func subtaskDone(subtask: inout TodoSubtaskProtocol) {
        guard let databaseManager, let todoTask else { return }
        databaseManager.update(subtask: subtask, in: todoTask)
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
        todoCell.delegate = self
        
        let todoSubTask = todoSubtasks[indexPath.row]
        todoCell.todoSubtask = todoSubTask
        todoCell.configure()
        
        return todoCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if let todoTask, editingStyle == .delete {
            databaseManager?.delete(subtask: todoSubtasks[indexPath.row], from: todoTask)
            todoSubtasks.remove(at: indexPath.row)
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
