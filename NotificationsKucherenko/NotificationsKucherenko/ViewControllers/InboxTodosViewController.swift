//
//  InboxTodosViewController.swift
//  NotificationsKucherenko
//
//  Created by Daniil on 13.10.2024.
//

import UIKit

class InboxTodosViewController: UIViewController {
    var databaseManager: (any DatabaseManager)?
    private var todos: [InboxTodoTaskProtocol] = []
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseManager = RealmDataManager.shared
        Task {
            await NotificationsManager.shared.requestPermission()
        }
        fetchInboxTodos()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            InboxTodoCellView.self,
            forCellReuseIdentifier: InboxTodoCellView.cellIdentifier
        )
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func fetchInboxTodos() {
        todos = databaseManager?.getAllInboxTodoTasks() ?? []
    }
}

// MARK: - UITableViewDataSource
extension InboxTodosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoCell = tableView.dequeueReusableCell(
            withIdentifier: InboxTodoCellView.cellIdentifier,
            for: indexPath
        ) as! InboxTodoCellView
        
        let todoTask = todos[indexPath.row]
        todoCell.todoTask = todoTask
        todoCell.configure()
        
        return todoCell
    }
}

extension InboxTodosViewController: UITableViewDelegate {}
