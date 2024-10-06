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
    
    private let completedCheckbox = CheckboxButton()
    private let name = UILabel()
    private let dueDate = UILabel()
    
    func configure(with todo: TodoTaskProtocol) {
        self.name.text = todo.name
        self.dueDate.text = todo.formattedDate
        self.completedCheckbox.isChecked = todo.isDone
        
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
}
