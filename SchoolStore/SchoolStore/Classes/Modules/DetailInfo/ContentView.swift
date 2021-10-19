//
//  ContentView.swift
//  SchoolStore
//
//  Created by a1 on 18.10.2021.
//

import Foundation
import AutoLayoutSugar
import UIKit

final class ContentView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var secondaryImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var thirdImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var fourhImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var departmentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sizeLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
//    var model: Product? {
//        didSet {
//
//        }
//    }
    
    private func setup() {
        self.addSubview(mainImageView)
        self.addSubview(secondaryImageView)
        self.addSubview(thirdImageView)
        self.addSubview(fourhImageView)
        self.addSubview(priceLabel)
        self.addSubview(badgeLabel)
        self.addSubview(productNameLabel)
        self.addSubview(departmentLabel)
        self.addSubview(sizeLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(separatorView)
        self.addSubview(detailsLabel)
        
        mainImageView.image = Asset.itemPlaceholder.image
        mainImageView.top().width(284).height(284).left(37.5)
        
        secondaryImageView.image = Asset.itemPlaceholder.image
        secondaryImageView.top(to: .bottom(20), of: mainImageView).left(121.5).width(32).height(32)
        
        thirdImageView.image = Asset.itemPlaceholder.image
        thirdImageView.top(to: .bottom(20), of: mainImageView).left(to: .right(10), of: secondaryImageView).width(32).height(32)
        
        fourhImageView.image = Asset.itemPlaceholder.image
        fourhImageView.top(to: .bottom(20), of: mainImageView).left(to: .right(10), of: thirdImageView).width(32).height(32)
        
        priceLabel.text = "9 000 Р"
        priceLabel.top(to: .bottom(20), of: secondaryImageView).left(16).width(228)
        
        badgeLabel.textColor = .white
        badgeLabel.backgroundColor = .systemGreen
        badgeLabel.layer.masksToBounds = true
        badgeLabel.layer.cornerRadius = 8
        badgeLabel.text = "Хит сезона!"
        badgeLabel.top(to: .bottom(20), of: secondaryImageView).left(to: .right(12), of: priceLabel).width(99)
        
        productNameLabel.text = "Men's Nike Tom Brady Red Tampa Bay Buccaneers Super Bowl LV Bound Game Jersey"
        productNameLabel.numberOfLines = 100
        productNameLabel.top(to: .bottom(16), of: priceLabel).left(16).width(327)
        
        departmentLabel.text = "Джерси"
        departmentLabel.top(to: .bottom(4), of: productNameLabel).left(16)
        
        sizeLabel.text = "2XL"
        sizeLabel.top(to: .bottom(16), of: departmentLabel).left(15.5).width(328)
        sizeLabel.textColor = .black
        sizeLabel.backgroundColor = .lightGray
        
        descriptionLabel.text = "The Tampa Bay Buccaneers are headed to Super Bowl LV! As a major fan, this is no surprise but it's definitely worth celebrating, especially after the unprecedented 2020 NFL season. Add this Tom Brady Game Jersey to your collection to ensure you're Super Bowl ready. This Nike gear features bold commemorative graphics that will let the Tampa Bay Buccaneers know they have the best fans in the league."
        descriptionLabel.numberOfLines = 100
        descriptionLabel.top(to: .bottom(16), of: sizeLabel).left(16).width(327)
        
        separatorView.backgroundColor = Asset.fieldBacground.color
        separatorView.top(to: .bottom(16), of: descriptionLabel).left(15.5).right(15.5).height(1)
        
        detailsLabel.text = "The Tampa Bay Buccaneers are headed to Super Bowl LV! As a major fan, this is no surprise but it's definitely worth celebrating, especially after the unprecedented 2020 NFL season. Add this Tom Brady Game Jersey to your collection to ensure you're Super Bowl ready. This Nike gear features bold commemorative graphics that will let the Tampa Bay Buccaneers know they have the best fans in the league."
        detailsLabel.numberOfLines = 100
        detailsLabel.top(to: .bottom(16), of: separatorView).left(16).width(327)

        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
