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
    private let securedLabel = UILabel()
    private let securedSwitch = UISwitch()
    
    var onSaveTask: ((String, Date, Bool) -> Void)?
    
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
        setupSecuredSwitchAndLabel()
        setupButtonsStackView()  // Using horizontal stack for buttons
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
    
    private func setupSecuredSwitchAndLabel() {
        securedLabel.text = "Secured"
        securedLabel.font = UIFont.systemFont(ofSize: 16)
        securedLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(securedLabel)
        
        securedSwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(securedSwitch)
        
        securedLabel.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.height.equalTo(30)
        }
        
        securedSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(securedLabel.snp.centerY)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
        }
    }
    
    // New method for setting up the buttons in a horizontal stack
    private func setupButtonsStackView() {
        // Set titles for buttons
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 10
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.backgroundColor = .systemGray
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.layer.cornerRadius = 10
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        // Create stack view and add buttons
        let buttonStackView = UIStackView(arrangedSubviews: [saveButton, cancelButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 16
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStackView)
        
        // Set constraints for the stack view
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(securedSwitch.snp.bottom).offset(40)
            make.leading.equalTo(view.snp.leading).offset(16)
            make.trailing.equalTo(view.snp.trailing).offset(-16)
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
    }

    // MARK: - Methods for modal dismissing
    @objc private func saveButtonTapped() {
        guard let taskName = taskNameTextField.text, !taskName.isEmpty else {
            return
        }
        let selectedDate = datePicker.date
        let isSecured = securedSwitch.isOn
        onSaveTask?(taskName, selectedDate, isSecured)
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}

