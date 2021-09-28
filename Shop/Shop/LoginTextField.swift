//
//  LoginTextField.swift
//  Shop
//
//  Created by a1 on 24.09.2021.
//

import UIKit

@IBDesignable
class LoginTextField: UITextField {
    
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
        placeholder = "Логин"
    }
    
    func isValid(email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
    
}
