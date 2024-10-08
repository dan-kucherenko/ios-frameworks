//
//  TaskModalViewController.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 08.10.2024.
//

import UIKit
import SnapKit

class TaskModalViewController: UIViewController {
    private let taskNameTextField = UITextField()
    private let datePicker = UIDatePicker()
    private let saveButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)
    
    var onSaveTask: ((String, Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.systemBackground
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        
        setupTaskNameTextField()
        setupDueDatePicker()
        setupSaveButton()
        setupCancelButton()
    }
    
    private func setupTaskNameTextField() {
        taskNameTextField.placeholder = "Task name"
        taskNameTextField.borderStyle = .roundedRect
        taskNameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(taskNameTextField)

        taskNameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(20)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.height.equalTo(40)
        }
    }
    
    private func setupDueDatePicker() {
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(taskNameTextField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
    private func setupSaveButton() {
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 10
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.addSubview(saveButton)

        saveButton.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(40)
            make.height.equalTo(50)
            make.width.equalTo(80)
            make.trailing.equalTo(view.snp.centerX).offset(-15)
        }
    }
    
    private func setupCancelButton() {
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.backgroundColor = .systemGray
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.layer.cornerRadius = 10
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        view.addSubview(cancelButton)

        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(40)
            make.height.equalTo(50)
            make.width.equalTo(saveButton.snp.width)
            make.leading.equalTo(view.snp.centerX).offset(15)
        }
    }
    
    
    // MARK: - Methods for modal dismissing
    @objc private func saveButtonTapped() {
        guard let taskName = taskNameTextField.text, !taskName.isEmpty else {
            return
        }
        let selectedDate = datePicker.date
        onSaveTask?(taskName, selectedDate)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
