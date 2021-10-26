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

class CheckoutView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
        createDatePicker()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        createDatePicker()
    }
    
    func fillWith(product: Product?) {
        guard let product = product else {
            return
        }
        
        //productTitle.text = product.title
        productTitle.textColor = Asset.textPrimary.color
        
        let price = NumberFormatter.rubString(from: product.price)
        buyButton.setTitle("Купить за \(price)", for: .normal)
        
        let size = product.sizes
        
        productTitle.text = "\(size[0].value)" + " · " + product.title

        departmentTitle.text = product.department
        departmentTitle.textColor = Asset.textSecondary.color

        if let previewUrl = URL(string: product.preview) {
            let contentImageResource = ImageResource(downloadURL: previewUrl, cacheKey: product.preview)
            contentImageView.kf.setImage(
                with: contentImageResource,
                placeholder: Asset.itemPlaceholder.image,
                options: [
                    .transition(.fade(0.2)),
                    .forceTransition,
                    .cacheOriginalImage,
                    .keepCurrentImageWhileLoading,
                ]
            )
        } else {
            contentImageView.image = Asset.itemPlaceholder.image
        }
    }
    
    private lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var productTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var departmentTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        btn.addTarget(self, action: #selector(plusBtnClick), for: .touchUpInside)
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
    
    private lazy var houseTF: InputField = {
        let tf = InputField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = Asset.textSecondary.color
        tf.layer.cornerRadius = 12
        return tf
    }()
    
    private lazy var flatNumberTF: InputField = {
        let tf = InputField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = Asset.textSecondary.color
        tf.layer.cornerRadius = 12
        return tf
    }()
    
    private lazy var deliveryDate: InputField = {
        let tf = InputField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = Asset.textSecondary.color
        tf.layer.cornerRadius = 12
//        tf.height(44)
//        tf.backgroundColor = Asset.textSecondary.color.withAlphaComponent(0.87)
        return tf
    }()
    
    private lazy var buyButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .blue
        btn.height(44)
        return btn
    }()
    
    private let datePicker = UIDatePicker()
    
    private func createToolBar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneBtnClick))
        
        toolbar.setItems([doneBtn], animated: true)
        
        return toolbar
    }
    
    private func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        deliveryDate.textField.inputView = datePicker
        deliveryDate.textField.inputAccessoryView = createToolBar()
    }
    
    private func setup() {
        addSubview(contentImageView)
        addSubview(productTitle)
        addSubview(departmentTitle)
        addSubview(stackView)
        addSubview(houseTF)
        addSubview(flatNumberTF)
        addSubview(deliveryDate)
        addSubview(buyButton)
        
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        stackView.addArrangedSubview(minusBtn)
        stackView.addArrangedSubview(indicator)
        stackView.addArrangedSubview(plusBtn)
        
        contentImageView.top(16).left(16).width(112).height(112)
        productTitle.top(16).left(to: .right(16), of: contentImageView).width(210)
        departmentTitle.left(to: .right(16), of: contentImageView).top(to: .bottom, of: productTitle)
            .width(210)
        stackView.left(to: .right(103), of: contentImageView).top(to: .bottom(27), of: departmentTitle)
            .right(17)
        houseTF.top(to: .bottom(48), of: stackView).left(16).right(16)
        flatNumberTF.top(to: .bottom(32), of: houseTF).left(16).right(16)
        deliveryDate.top(to: .bottom(32), of: flatNumberTF).left(16).right(16)
        buyButton.bottom(27).left(16).right(16)
        
        houseTF.title = "Адрес"
        flatNumberTF.title = "Квартира"
        deliveryDate.title = "Дата доставки"
        //buyButton.setTitle("Купить", for: .normal)
        
        departmentTitle.font = UIFont(name: "Roboto-Regular", size: 12)
        productTitle.font = UIFont(name: "Roboto-Regular", size: 14)
        
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
    
    @objc
    func doneBtnClick() {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        self.deliveryDate.text = dateFormatter.string(from: datePicker.date)
        self.endEditing(true)
    }

}
