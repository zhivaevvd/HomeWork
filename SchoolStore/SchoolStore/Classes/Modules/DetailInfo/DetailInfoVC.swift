//
//  DetailInfoVC.swift
//  SchoolStore
//
//  Created by a1 on 18.10.2021.
//

import Foundation
import AutoLayoutSugar
import UIKit

class DetailInfoVC: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    
    private var product: Product? 
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: .zero)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Купить сейчас", for: .normal)
        button.layer.cornerRadius = 12
        
        return button
    }()
    
    private let contentView = ContentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        //scrollView.top().left().right().bottom()
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(buyButton)
        buyButton.bottom(70).left(20).right(20).height(44)
        
        scrollView.addSubview(contentView)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor, multiplier: 1.5).isActive = true
        
    }
    
    
    @IBAction func backToTabbar(_ sender: UIButton) {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController = VCFactory.buildTabBarVC()
    }
}
