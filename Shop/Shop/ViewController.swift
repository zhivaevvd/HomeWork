//
//  ViewController.swift
//  Shop
//
//  Created by a1 on 24.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginTF: LoginTextField!
    @IBOutlet weak var loginErrorMessage: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var loginMistView: UIView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var passwordMistView: UIView!
    @IBOutlet weak var passwordTF: PasswordTextField!
    @IBOutlet weak var passwordErrorMessage: UILabel!
    @IBOutlet weak var signInBtn: SignInButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTF.addTarget(self, action: #selector(isLogTFValid), for: .allEditingEvents)
        passwordTF.addTarget(self, action: #selector(isPassValid), for: .allEditingEvents)
        
        loginTF.addTarget(self, action: #selector(showOrHideLoginLabel), for: .allEditingEvents)
        passwordTF.addTarget(self, action: #selector(showOrHidePassLabel), for: .allEditingEvents)

        loginTF.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
                if textField.text?.first == " " {
                    textField.text = ""
                    return
                }
            }
        

        guard let login = loginTF.text, !login.isEmpty,
              let pass = passwordTF.text, !pass.isEmpty,
              let logMV = loginMistView,
              let passMV = passwordMistView

        else {
            signInBtn.isEnabled = false
            return
        }

        if logMV.isHidden && passMV.isHidden {
            signInBtn.isEnabled = true
        } else {
            signInBtn.isEnabled = false
        }
    }

    @objc func isLogTFValid() {
        if !loginTF.isValid(email: loginTF.text!) {
            loginMistView.isHidden = false
            loginErrorMessage.isHidden = false
        } else {
            loginMistView.isHidden = true
            loginErrorMessage.isHidden = true
        }
    }
    
    @objc func isPassValid() {
        if !passwordTF.isValid(pass: passwordTF.text!) {
            passwordMistView.isHidden = false
            passwordErrorMessage.isHidden = false
        } else {
            passwordMistView.isHidden = true
            passwordErrorMessage.isHidden = true
        }
    }

    @objc func showOrHideLoginLabel() {
        if loginTF.text?.count == 0 {
            loginLabel.isHidden = true
        } else {
            loginLabel.isHidden = false
        }
    }
    
    @objc func showOrHidePassLabel() {
        if passwordTF.text?.count == 0 {
            passwordLabel.isHidden = true
        } else {
            passwordLabel.isHidden = false
        }
    }
    
    
    @IBAction func loginBtnClick(_ sender: Any) {
        
        signInBtn.animateButton(shouldLoad: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            let window = UIApplication.shared.windows.first{
                $0.isKeyWindow
            }
            
            if let vc: UIViewController = UIStoryboard(name: "TabBar", bundle: nil).instantiateInitialViewController() {
                window?.rootViewController = vc
            }
        })
    }
    
}

