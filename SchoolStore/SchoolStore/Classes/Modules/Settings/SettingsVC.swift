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
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToSuperview()
        //scrollView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor).activate()
        contentView.pinToSuperview()
            .width(as: scrollView)
        
        scrollView
            .heightAnchor
            .constraint(lessThanOrEqualTo: contentView.heightAnchor)
            .activate()
        
//        view.addSubview(contentView)
//        scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).activate()
//        scrollView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).activate()
//        scrollView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).activate()
//        scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).activate()
        
        contentView.profileService = profileService
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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    //private lazy var occupationTF = contentView.occupationTF
    
    var profileService: ProfileService?
}
