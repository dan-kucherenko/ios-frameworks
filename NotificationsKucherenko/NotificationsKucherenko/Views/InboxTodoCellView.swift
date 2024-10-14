//
//  InboxTodoCellView.swift
//  NotificationsKucherenko
//
//  Created by Daniil on 13.10.2024.
//

import UIKit
import SnapKit

class InboxTodoCellView: UITableViewCell {
    static let cellIdentifier = "inboxTodoCell"
    
    var todoTask: InboxTodoTaskProtocol?
    
    private let name = UILabel()
    private let dueDate = UILabel()
    
    func configure() {
        guard let todoTask else { return }
        self.name.text = todoTask.name
        self.name.font = .boldSystemFont(ofSize: 16)
        
        self.dueDate.text = todoTask.formattedDate
        self.dueDate.font = .systemFont(ofSize: 14)
        
        self.backgroundColor = todoTask.isApproved ? .systemGreen : .systemRed
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.contentView.addSubview(name)
        self.contentView.addSubview(dueDate)
        
        name.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
        }
        
        dueDate.snp.makeConstraints { make in
            make.leading.equalTo(name.snp.leading)
            make.top.equalTo(name.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    override func prepareForReuse() {
        name.removeFromSuperview()
        dueDate.removeFromSuperview()
    }
}
