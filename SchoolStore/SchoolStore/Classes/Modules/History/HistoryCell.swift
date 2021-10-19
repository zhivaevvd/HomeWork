//
//  HistoryCell.swift
//  SchoolStore
//
//  Created by a1 on 14.10.2021.
//

import Foundation
import UIKit
import AutoLayoutSugar

@IBDesignable
final class HistoryCell: UITableViewCell {
    private lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var orderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var orderStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var productLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var deliveryTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    var model: String? {
        didSet {
            orderLabel.text = model
        }
    }
    
    private func setup() {
        selectionStyle = .none
        
        contentView.addSubview(contentImageView)
        contentView.addSubview(orderLabel)
        contentView.addSubview(orderStatusLabel)
        contentView.addSubview(productLabel)
        contentView.addSubview(deliveryTimeLabel)
        contentView.addSubview(separatorView)
        
//        [contentImageView, orderLabel, orderStatusLabel, productLabel, deliveryTimeLabel].forEach {
//            $0.layer.borderWidth = 1
//            $0.layer.borderColor = UIColor.red.cgColor
//        }
        
        contentImageView.top(16).left(16).bottom(69).width(63).height(64)
        contentImageView.image = Asset.itemPlaceholder.image
        
        orderLabel.top(16).left(to: .right(8), of: contentImageView).right(128.98)
        
        orderStatusLabel.top(to: .bottom(8), of: orderLabel).left(to: .right(8), of: contentImageView)
        orderStatusLabel.text = "Выполняется"
        
        productLabel.top(to: .bottom(8), of: orderStatusLabel).left(to: .right(8), of: contentImageView)
        productLabel.text = "Product"
        
        deliveryTimeLabel.top(to: .bottom(8), of: productLabel).left(87.02).right(15.98).bottom(16)
        deliveryTimeLabel.text = "Куда-нибудь, когда угодно"
        
        separatorView.bottom().left(16).right(16).height(1)
        separatorView.backgroundColor = UIColor.gray
    }
}


