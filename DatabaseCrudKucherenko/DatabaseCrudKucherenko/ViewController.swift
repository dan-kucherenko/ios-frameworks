//
//  ViewController.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 02.10.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private var todos: [Todo?] = [.mock]
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupTableView()
    }

    private func setupHeader() {
        self.navigationItem.title = "Todos List"
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TodoCellView.self, forCellReuseIdentifier: TodoCellView.cellIdentifier)
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
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
        
        guard let todoTask else { return todoCell}
        
        todoCell.configure(with: todoTask)
        
        return todoCell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
}

#Preview {
    ViewController()
}
