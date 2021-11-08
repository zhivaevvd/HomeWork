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
        
        setup()
    }
    
    var profile: Profile? {
        didSet {
            contentView.fillWith(profile: profile)
        }
    }
    
    private func setup() {
        contentView.profileService = profileService
        contentView.viewController = self
        contentView.snacker = snacker
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
    
    var profileService: ProfileService?
    
    var snacker: Snacker?
}
