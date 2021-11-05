//
//  SettingsView.swift
//  SchoolStore
//
//  Created by a1 on 29.10.2021.
//

import Foundation
import UIKit
import AutoLayoutSugar
import Kingfisher

final class SettingsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func fillWith(profile: Profile?) {
        guard let profile = profile else {
            return
        }
        
        nameTF.textField.text = profile.name
        surnameTF.textField.text = profile.surname
        occupationTF.textField.text = profile.occupation
        
        nameTF.titleLabel.isHidden = false
        surnameTF.titleLabel.isHidden = false
        occupationTF.titleLabel.isHidden = false
        
        nameTF.title = "Имя"
        surnameTF.title = "Фамилия"
        occupationTF.title = "Род деятельности"
    }
    
    var userService: UserService?
    
    var viewController: UIViewController?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Asset.imagePlaceholder.image
        imageView.height(90).width(90)
        imageView.backgroundColor = .systemGray5
        imageView.layer.cornerRadius = 45
        return imageView
    }()
    
    private lazy var nameTF: InputField = {
        let textField = InputField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private lazy var surnameTF: InputField = {
        let textField = InputField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    public lazy var occupationTF: InputField = {
        let textField = InputField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        textField.textField.addTarget(self, action: #selector(test), for: [.allEditingEvents, .allTouchEvents])
        return textField
    }()
    
    private lazy var changeButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .systemBlue
        btn.setTitle(L10n.Settings.buttonChange, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.addTarget(self, action: #selector(tapBtn), for: .touchUpInside)
        return btn
    }()
    
    public lazy var anotherOccupationTF: InputField = {
        let textField = InputField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private func setup() {
        addSubview(imageView)
        addSubview(nameTF)
        addSubview(surnameTF)
        addSubview(occupationTF)
        addSubview(changeButton)
        
        imageView.top(50).centerX()
        nameTF.top(to: .bottom(32), of: imageView).left(16).right(16)
        surnameTF.top(to: .bottom(32), of: nameTF).left(16).right(16)
        occupationTF.top(to: .bottom(32), of: surnameTF).left(16).right(16)
        changeButton.left(16).right(16).bottom(16).height(44)
        
        let iconView = UIImageView()
        var icon = UIImage(systemName: "arrowshape.zigzag.right.fill")
        
        icon  = icon?.withRenderingMode(.alwaysTemplate)
        occupationTF.tintColor = .black
        iconView.image = icon
        
        occupationTF.textField.rightViewMode = .always
        occupationTF.textField.rightView = iconView
    }
    
    @objc
    func test() {
        let array = [
            L10n.Specialization.developer,
            L10n.Specialization.tester,
            L10n.Specialization.tractorDriver,
            L10n.Specialization.another
        ]
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.translatesAutoresizingMaskIntoConstraints = false

        array.forEach { specialization in
        let button = UIButton()
        button.height(44)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(specialization, for: .normal)
        button.addTarget(self, action: #selector(specializationDidTap), for: .touchUpInside)
        view.addArrangedSubview(button)
        }

        let vc = VCFactory.buildBottomSheetController(
                with: view,
                onEveryTapOut: nil
            )

        viewController?.present(vc, animated: true, completion: nil)
    }
    
        @objc
        func specializationDidTap(_ sender: UIButton) {
            guard let text = sender.titleLabel?.text else { return }
            occupationTF.textField.text = text
    
            if occupationTF.textField.text == L10n.Specialization.another {
                addSubview(anotherOccupationTF)
                anotherOccupationTF.top(to: .bottom(32), of: occupationTF).left(16).right(16)
                anotherOccupationTF.textField.placeholder = L10n.Settings.anotherOccupation
                anotherOccupationTF.title = L10n.Settings.anotherOccupation
            } else {
                anotherOccupationTF.isHidden = true
            }
    
            viewController?.presentedViewController?.dismiss(animated: true, completion: nil)
        }
   
    //хуйня
    @objc
    func tapBtn() {
        guard let name = nameTF.textField.text,
              let surname = surnameTF.textField.text,
              let occupation = occupationTF.textField.text
        else {
            return
        }
        
        let avatar = ""
        userService?.userChange(name: name, surname: surname, occupation: occupation, avatar: avatar, completion: {
            (result: Result<Void, Error>) in
            guard case .success = result else {
                return
            }
            print("succ")
        })
    }
}

