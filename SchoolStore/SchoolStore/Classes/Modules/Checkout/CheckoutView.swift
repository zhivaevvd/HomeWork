//
//  CheckoutView.swift
//  SchoolStore
//
//  Created by a1 on 25.10.2021.
//

import Foundation
import UIKit
import Kingfisher
import AutoLayoutSugar

final class CheckoutView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Asset.itemPlaceholder.image
        return imageView
    }()
    
    private lazy var productTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "test tuppa"
        return label
    }()
    
    private lazy var departmentTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Asset.textSecondary.color
        label.text = "Jersey"
        return label
    }()
    
    private lazy var plusBtn: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("+", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .lightGray
        btn.layer.cornerRadius = 8
        btn.width(32).height(28)
        return btn
    }()
    
    private lazy var minusBtn: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("-", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .lightGray
        btn.layer.cornerRadius = 8
        btn.width(32).height(28)
        return btn
    }()
    
    private lazy var indicator: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.layer.cornerRadius = 8
        sv.layer.borderWidth = 1.0
        sv.layer.borderColor = UIColor.lightGray.cgColor
        sv.distribution = .fillEqually
        sv.alignment = .center
        return sv
    }()
    
    private func setup() {
        addSubview(contentImageView)
        addSubview(productTitle)
        addSubview(departmentTitle)
        addSubview(stackView)
        
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        stackView.addArrangedSubview(minusBtn)
        stackView.addArrangedSubview(indicator)
        stackView.addArrangedSubview(plusBtn)
        
        contentImageView.top(16).left(16).width(112).height(112)
        productTitle.top(16).left(to: .right(16), of: contentImageView).width(210)
        departmentTitle.left(to: .right(16), of: contentImageView).top(to: .bottom, of: productTitle)
            .width(210)
        stackView.left(to: .right(103), of: contentImageView).top(to: .bottom(32), of: departmentTitle)
        
        departmentTitle.font = UIFont(name: "Roboto-Regular", size: 20)
        productTitle.font = UIFont(name: "Roboto-Regular", size: 36)
        
        minusBtn.addTarget(self, action: #selector(minusBtnClick), for: .touchUpInside)
        plusBtn.addTarget(self, action: #selector(plusBtnClick), for: .touchUpInside)
        
    }
    
    @objc
    func plusBtnClick() {
        guard let labelText = indicator.text else { return }
        guard var itemCount = Int(labelText) else { return }

        itemCount += 1

        indicator.text = String(itemCount)
    }
    
    @objc
    func minusBtnClick() {
        guard let labelText = indicator.text else { return }
        guard var itemCount = Int(labelText) else { return }

        itemCount -= 1

        if itemCount < 0 {
            indicator.text = labelText
        } else {
            indicator.text = String(itemCount)
        }
    }

}
