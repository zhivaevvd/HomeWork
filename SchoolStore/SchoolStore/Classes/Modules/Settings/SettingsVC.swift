//
//  SettingsVC.swift
//  SchoolStore
//
//  Created by a1 on 29.10.2021.
//

import Foundation
import UIKit
import AutoLayoutSugar

final class SettingsVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Settings.title
        view.backgroundColor = .white
        
        view.addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).activate()
        contentView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).activate()
        contentView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).activate()
        contentView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).activate()
        
       // view.addSubview(changeButton)
        //changeButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).activate()
        //changeButton.left(16).right(16).height(44)
        
        //occupationTF.textField.addTarget(self, action: #selector(test), for: [.allEditingEvents, .allTouchEvents])
        
        contentView.userService = userService
        contentView.viewController = self
    }
    
    var profile: Profile? {
        didSet {
            contentView.fillWith(profile: profile)
        }
    }
    
    private lazy var contentView: SettingsView = {
        let contentView = SettingsView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var occupationTF = contentView.occupationTF
    
    var userService: UserService?
    
//    public lazy var anotherOccupationTF: InputField = {
//        let textField = InputField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.backgroundColor = Asset.textSecondary.color
//        textField.layer.cornerRadius = 10
//        return textField
//    }()
    
//    private lazy var changeButton: UIButton = {
//        let btn = UIButton()
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.backgroundColor = .systemBlue
//        btn.setTitle(L10n.Settings.buttonChange, for: .normal)
//        btn.setTitleColor(.white, for: .normal)
//        btn.layer.cornerRadius = 8
//        return btn
//    }()
    
//    @objc
//    func test() {
//        let array = [
//            L10n.Specialization.developer,
//            L10n.Specialization.tester,
//            L10n.Specialization.tractorDriver,
//            L10n.Specialization.another
//        ]
//        let view = UIStackView()
//        view.axis = .vertical
//        view.alignment = .leading
//        view.translatesAutoresizingMaskIntoConstraints = false
//        
//        array.forEach { specialization in
//        let button = UIButton()
//        button.height(44)
//        button.setTitleColor(.blue, for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setTitle(specialization, for: .normal)
//        button.addTarget(self, action: #selector(specializationDidTap), for: .touchUpInside)
//        view.addArrangedSubview(button)
//        }
//                
//        let vc = VCFactory.buildBottomSheetController(
//                with: view,
//                onEveryTapOut: nil
//            )
//        
//        present(vc, animated: true, completion: nil)
//    }
    
//    @objc
//    func specializationDidTap(_ sender: UIButton) {
//        guard let text = sender.titleLabel?.text else { return }
//        occupationTF.textField.text = text
//
//        if occupationTF.textField.text == L10n.Specialization.another {
//            contentView.addSubview(anotherOccupationTF)
//            anotherOccupationTF.top(to: .bottom(32), of: occupationTF).left(16).right(16)
//            anotherOccupationTF.textField.placeholder = L10n.Settings.anotherOccupation
//            anotherOccupationTF.title = L10n.Settings.anotherOccupation
//        } else {
//            anotherOccupationTF.isHidden = true
//        }
//
//        presentedViewController?.dismiss(animated: true, completion: nil)
//    }
}
