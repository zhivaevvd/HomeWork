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
        
        if let preview = profile.avatarUrl, let previewUrl = URL(string: preview) {
            let contentImageResource = ImageResource(downloadURL: previewUrl, cacheKey: preview)
            imageView.kf.setImage(with: contentImageResource, placeholder: Asset.itemPlaceholder.image, options: [
                .transition(.fade(0.2)),
                .forceTransition,
                .cacheOriginalImage,
                .keepCurrentImageWhileLoading,
                ]
            )
        } else {
            imageView.image = Asset.itemPlaceholder.image
        }
        
        nameTF.textField.text = profile.name
        surnameTF.textField.text = profile.surname
        occupationTF.textField.text = profile.occupation
        
        nameTF.titleLabel.isHidden = false
        surnameTF.titleLabel.isHidden = false
        occupationTF.titleLabel.isHidden = false
        
        nameTF.title = L10n.Settings.name
        surnameTF.title = L10n.Settings.surname
        occupationTF.title = L10n.Settings.anotherOccupation
        
        guard let name = nameTF.textField.text,
              let surname = surnameTF.textField.text,
              let occupation = occupationTF.textField.text
        else {
            return
        }
        
        currentInfo = ["name": name, "surname": surname, "occupation": occupation]
        avatar = profile.avatarUrl
    }
    
    var profileService: ProfileService?
    
    var currentInfo: [String: String]?
    
    var viewController: UIViewController?
    
    var avatar: String?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray
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
    
    private lazy var occupationTF: InputField = {
        let textField = InputField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        textField.textField.addTarget(self, action: #selector(showBottomSheet), for: [.allEditingEvents, .allTouchEvents])
        return textField
    }()
    
    private lazy var changeButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .systemBlue
        btn.setTitle(L10n.Settings.buttonChange, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.addTarget(self, action: #selector(changeButtonDidTap), for: .touchUpInside)
        return btn
    }()
    
    public lazy var anotherOccupationTF: InputField = {
        let textField = InputField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .white
        return indicator
    }()
    
    private func setup() {
        addSubview(imageView)
        addSubview(nameTF)
        addSubview(surnameTF)
        addSubview(occupationTF)
        addSubview(changeButton)
        
        imageView.top(50).centerX()
        imageView.height(90).width(90)
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true
        
        nameTF.top(to: .bottom(32), of: imageView).left(16).right(16)
        surnameTF.top(to: .bottom(32), of: nameTF).left(16).right(16)
        occupationTF.top(to: .bottom(32), of: surnameTF).left(16).right(16)
        changeButton.left(16).right(16).top(to: .bottom(100), of: occupationTF).height(44)
        changeButton.addSubview(indicator)
        
        indicator.topAnchor.constraint(equalTo: changeButton.topAnchor).activate()
        indicator.centerX().centerY()
        
        let iconView = UIImageView()
        var icon = UIImage(systemName: "arrowshape.zigzag.right.fill")
        
        icon  = icon?.withRenderingMode(.alwaysTemplate)
        occupationTF.tintColor = .black
        iconView.image = icon
        
        occupationTF.textField.rightViewMode = .always
        occupationTF.textField.rightView = iconView
    }
    
    @objc
    func showBottomSheet() {
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
   
    @objc
    func changeButtonDidTap() {
        guard let name = nameTF.textField.text,
              let surname = surnameTF.textField.text,
              var occupation = occupationTF.textField.text,
              let avatar = avatar
        else {
            return
        }
        
        if occupation == L10n.Specialization.another {
            guard let anotherOccupation = anotherOccupationTF.textField.text else {
                return
            }
            occupation = anotherOccupation
        }
        
        if name != currentInfo?["name"] || surname != currentInfo?["surname"] || occupation != currentInfo?["occupation"] {
            profileService?.userChange(name: name, surname: surname, occupation: occupation, avatar: avatar, completion: {
                (result: Result<Void, Error>) in
                guard case .success = result else {
                    return
                }
                print("succ")
                self.indicator.startAnimating()
                self.changeButton.setTitle("", for: .normal)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.viewController?.navigationController?.popToRootViewController(animated: true)
                })
            })
        } else {
            self.indicator.stopAnimating()
        }
    }
}

