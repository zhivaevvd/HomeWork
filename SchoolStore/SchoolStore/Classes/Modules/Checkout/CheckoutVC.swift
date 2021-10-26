//
//  CheckoutVC.swift
//  SchoolStore
//
//  Created by a1 on 22.10.2021.
//

import Foundation
import UIKit
import AutoLayoutSugar
import Kingfisher

final class CheckoutVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.Checkout.title
        view.backgroundColor = .white
        
        view.addSubview(contentView)
        contentView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).activate()
    }
    
    var product: Product?
    
    private lazy var contentView: CheckoutView = {
        let contentView = CheckoutView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
}
