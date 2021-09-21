//
//  ViewController.swift
//  Registration
//
//  Created by a1 on 20.09.2021.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    @IBOutlet weak var bdateTF: UITextField!
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    
    @IBAction func onBtnClick(_ sender: UIButton) {
        guard let name = nameTF.text,
              let surname = surnameTF.text,
              let bdate = bdateTF.text,
              let login = loginTF.text,
              let pass = passTF.text
              
        else {
            return
        }
        
        var num = [Int]()
        
        if !isValid(str: name) {
            nameTF.backgroundColor = .red
            num.append(1)
        } else {
            nameTF.backgroundColor = .white
            nameTF.textColor = .black
        }
        
        if !isValid(str: surname) {
            surnameTF.backgroundColor = .red
            num.append(1)
        } else {
            surnameTF.backgroundColor = .white
            surnameTF.textColor = .black
        }
        
        if !isDateValid(date: bdate) {
            bdateTF.backgroundColor = .red
            num.append(1)
        } else {
            bdateTF.backgroundColor = .white
            bdateTF.textColor = .black
        }
        
        if login.count == 0 {
            loginTF.backgroundColor = .red
            num.append(1)
        } else {
            loginTF.backgroundColor = .white
            loginTF.textColor = .black
        }
        
        if pass.count == 0 || pass.count < 4 {
            passTF.backgroundColor = .red
            num.append(1)
        } else {
            passTF.backgroundColor = .white
            passTF.textColor = .black
        }
        
        if num.count == 0{
            signUpBtn.backgroundColor = .green
        } else {
            signUpBtn.backgroundColor = .blue
        }
        
    }
    
    func isValid(str: String) -> Bool {
        if str.count == 0 || hasNumbers(str: str) {
            return false
        } else {
            return true
        }
    }
    
    func hasNumbers(str: String) -> Bool {
        let numbers = CharacterSet.decimalDigits
        let numRange = str.rangeOfCharacter(from: numbers)
        
        if numRange != nil {
            return true
        } else {
            return false
        }
    }
    
    func isDateValid(date: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = .none
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let currentDate = NSDate()
        let enteredDate = dateFormatter.date(from: date)
        
        let calendar = Calendar.current
        
        let currDateComponents = calendar.dateComponents([.day, .month, .year], from: currentDate as Date)
        let enteredDateComponents = calendar.dateComponents([.day, .month, .year], from: enteredDate!)
        
        if date.count == 0 {
            return false
        } else if (enteredDateComponents.year! as Int) > (currDateComponents.year! as Int) || (enteredDateComponents.year! as Int) < 1930{
            return false
        } else if (enteredDateComponents.month! as Int) > (currDateComponents.month! as Int) {
            return false
        } else {
            return true
        }
    }
    
    let datePicker = UIDatePicker()
    
    func createToolBar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneBtnClick))
        
        toolbar.setItems([doneBtn], animated: true)
        
        return toolbar
    }
    
    func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        bdateTF.inputView = datePicker
        bdateTF.inputAccessoryView = createToolBar()
    }
    
    @objc func doneBtnClick() {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        self.bdateTF.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpBtn.layer.cornerRadius = 12
        signUpBtn.backgroundColor = .blue
        
        createDatePicker()
    }
}

