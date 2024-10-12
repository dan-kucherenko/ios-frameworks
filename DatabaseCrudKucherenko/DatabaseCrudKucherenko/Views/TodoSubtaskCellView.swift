//
//  TodoSubtaskCellView.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 08.10.2024.
//

import UIKit

class TodoSubtaskCellView: UITableViewCell {
    static let cellIdentifier = "todoSubtaskCell"

    weak var delegate: SubtaskDoneProtocol?
    var todoSubtask: TodoSubtaskProtocol?
    
    private let completedCheckbox = CheckboxButton()
    private let name = UILabel()
    
    func configure() {
        guard let todoSubtask else { return }
        self.name.text = todoSubtask.name
        self.completedCheckbox.isChecked = todoSubtask.isDone
        
        self.completedCheckbox.addTarget(
            nil,
            action: #selector(markTaskAsDone),
            for: .touchUpInside
        )
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.contentView.addSubview(name)
        self.contentView.addSubview(completedCheckbox)
        
        name.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        completedCheckbox.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        name.removeFromSuperview()
        completedCheckbox.removeFromSuperview()
    }
    
    @objc private func markTaskAsDone() {
        guard var todoSubtask else { return }
        delegate?.subtaskDone(subtask: &todoSubtask)
    }
}
