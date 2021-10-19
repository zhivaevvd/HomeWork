// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import AutoLayoutSugar
import Foundation
import UIKit

final class ProductCell: UITableViewCell {
    // MARK: Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: Internal

    var model: Product? {
        didSet {
            titleLabel.text = model?.title
            descriptionLabel.text = model?.department
            
            guard let price = model?.price else {
                return
            }
            
            let url = URL(string: (model?.images.first)!)
            let data = try? Data(contentsOf: url!)
            contentImageView.image = UIImage(data: data!)
           
            priceLabel.text = String(price.formattedWithSeparator) + " ₽"
        }
    }

    // MARK: Private

    private lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private func setup() {
        selectionStyle = .none
        contentView.addSubview(contentImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(addToCartButton)
        contentView.addSubview(separatorView)

        //contentImageView.image = Asset.itemPlaceholder.image
        contentImageView
            .top(16).left(16).bottom(16).width(112).height(112)

        titleLabel
            .top(16).left(to: .right(16), of: contentImageView)
            .right(16)
        titleLabel.numberOfLines = 5
        titleLabel.font = UIFont(name: "Roboto-Regular", size: 16)
        titleLabel.textColor = .black

        descriptionLabel
            .top(to: .bottom, of: titleLabel)
            .left(to: .right(16), of: contentImageView).right(16)
        descriptionLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        descriptionLabel.textColor = UIColor.systemGray

        priceLabel
            .bottom(21)
            .left(to: .right(16), of: contentImageView)
        priceLabel.font = UIFont(name: "Roboto-Regular", size: 16)
        
        addToCartButton
            .top(to: .top, of: priceLabel)
            .bottom(31)
            .left(to: .right(16), of: priceLabel).right(16)
        addToCartButton.setTitle("Купить", for: .normal)
        addToCartButton.setTitleColor(UIColor.systemBlue, for: .normal)
        addToCartButton.setImage(UIImage.init(systemName: "cart"), for: .normal)

        separatorView.backgroundColor = Asset.fieldBacground.color
        separatorView.bottom().left(16).right(16).height(1)
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Int {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
