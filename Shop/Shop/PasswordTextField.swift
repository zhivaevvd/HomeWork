//
//  PasswordTextField.swift
//  Shop
//
//  Created by a1 on 24.09.2021.
//

import UIKit

@IBDesignable
class PasswordTextField: UITextField {

    let showPass = UIButton()
    let eyeFill = UIImage(systemName: "eye.fill")
    let eyeSlashFill = UIImage(systemName: "eye.slash.fill")

    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        backgroundColor = .systemGray5
        placeholder = "Пароль"
        isSecureTextEntry = true
        
        showPass.setImage(eyeFill, for: .normal)
        
        rightViewMode = .always
        rightView = showPass
        
        showPass.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.addTarget(self, action: #selector(isPassTFValid), for: .allEditingEvents)
    }
    
    @objc func buttonAction() {
        isSecureTextEntry.toggle()

        if let existingText = text, isSecureTextEntry {
            deleteBackward()

            if let textRange = textRange(from: beginningOfDocument, to: endOfDocument) {
                replace(textRange, withText: existingText)
            }
        }

        if let existingSelectedTextRange = selectedTextRange {
            selectedTextRange = nil
            selectedTextRange = existingSelectedTextRange
        }
    }

    func isValid(pass: String) -> Bool {
        if pass.count == 0 || pass.count < 6 {
            return false
        } else {
            return true
        }
    }
    
    @objc func isPassTFValid() {
        guard let pass = self.text
        else {
            return
        }
        
        if isValid(pass: pass) {
            self.backgroundColor = .green
        } else {
            self.backgroundColor = .red
        }
    }
    
}
