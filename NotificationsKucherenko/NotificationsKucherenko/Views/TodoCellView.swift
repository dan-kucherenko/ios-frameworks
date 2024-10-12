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
    
    weak var delegate: TodoTaskDelegate?
    var todoTask: TodoTaskProtocol?
    
    private let completedCheckbox = CheckboxButton()
    private let name = UILabel()
    private let dueDate = UILabel()
    private let alarmBtn = UIButton()
    
    func configure() {
        guard let todoTask else { return }
        self.name.text = todoTask.name
        self.dueDate.text = todoTask.formattedDate
        self.completedCheckbox.isChecked = todoTask.isDone
        self.alarmBtn.isSelected = todoTask.isNotifying
        
        self.completedCheckbox.addTarget(
            nil,
            action: #selector(markTaskAsDone),
            for: .touchUpInside
        )
        setupAlarm()
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.contentView.addSubview(name)
        self.contentView.addSubview(dueDate)
        self.contentView.addSubview(completedCheckbox)
        self.contentView.addSubview(alarmBtn)
        
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
        
        alarmBtn.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.trailing.equalTo(completedCheckbox.snp.trailing).offset(-30)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupAlarm() {
        if todoTask?.isNotifying == true {
            alarmBtn.setImage(UIImage(systemName: "bell.fill"), for: .normal)
            alarmBtn.tintColor = .systemYellow
        } else {
            alarmBtn.setImage(UIImage(systemName: "bell.slash.fill"), for: .normal)
            alarmBtn.tintColor = .systemGray
        }
        alarmBtn.addTarget(self, action: #selector(alarmBtnTapped), for: .touchUpInside)
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
    
    @objc private func alarmBtnTapped() {
        if todoTask?.isNotifying == true {
            alarmBtn.setImage(UIImage(systemName: "bell.slash.fill"), for: .normal)
            alarmBtn.tintColor = .systemGray
            
            guard var todoTask else { return }
            delegate?.alarmSetting(task: &todoTask)
            NotificationsManager.shared.cancelNotification(for: todoTask)
        } else {
            alarmBtn.setImage(UIImage(systemName: "bell.fill"), for: .normal)
            alarmBtn.tintColor = .systemYellow
            
            Task {
                guard var todoTask else { return }
                delegate?.alarmSetting(task: &todoTask)
                await NotificationsManager.shared.turnNotification(for: todoTask)
            }
        }
    }
}
