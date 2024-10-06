//
//  CheckboxButton.swift
//  DatabaseCrudKucherenko
//
//  Created by Daniil on 05.10.2024.
//

import UIKit

class CheckboxButton: UIButton {
    let checkedImage = UIImage(systemName: "checkmark.square.fill")
    let uncheckedImage = UIImage(systemName: "square")
    
    var isChecked: Bool = false {
        didSet {
            self.updateImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    private func setup() {
        self.updateImage()
        self.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
    }
    
    private func updateImage() {
        let image = isChecked ? checkedImage : uncheckedImage
        self.setImage(image, for: .normal)
    }
    
    @objc private func toggleCheckbox() {
        isChecked.toggle()
    }
}
