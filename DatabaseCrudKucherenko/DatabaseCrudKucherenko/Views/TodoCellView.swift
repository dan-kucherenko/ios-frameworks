//
//  TodoView.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 05.10.2024.
//

import UIKit
import SnapKit

class TodoCellView: UITableViewCell {
    static let cellIdentifier = "todoCell"

    weak var delegate: TaskDoneProtocol?
    var todoTask: TodoTaskProtocol?
    
    private let completedCheckbox = CheckboxButton()
    private let name = UILabel()
    private let dueDate = UILabel()
    
    func configure(/*with todo: TodoTaskProtocol*/) {
        guard let todoTask else { return }
        self.name.text = todoTask.name
        self.dueDate.text = todoTask.formattedDate
        self.completedCheckbox.isChecked = todoTask.isDone
        
        self.completedCheckbox.addTarget(
            nil,
            action: #selector(markTaskAsDone),
            for: .touchUpInside
        )
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.contentView.addSubview(name)
        self.contentView.addSubview(dueDate)
        self.contentView.addSubview(completedCheckbox)
        
        name.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
        }
        
        dueDate.snp.makeConstraints { make in
            make.leading.equalTo(name.snp.leading)
            make.top.equalTo(name.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        completedCheckbox.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        name.removeFromSuperview()
        dueDate.removeFromSuperview()
        completedCheckbox.removeFromSuperview()
    }
    
    @objc private func markTaskAsDone() {
        guard var todoTask else { return }
        delegate?.taskDone(task: &todoTask)
    }
}
