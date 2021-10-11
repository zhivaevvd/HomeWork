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

    var model: String? {
        didSet {
            titleLabel.text = model
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

        contentImageView.image = Asset.itemPlaceholder.image
        contentImageView
            .top(16).left(16).bottom(16).width(112).height(112)

        titleLabel
            .top(16).left(to: .right(16), of: contentImageView)
            .right(16)
        titleLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        titleLabel.text = "Some text"
        
        descriptionLabel.text = "Some text"
        descriptionLabel.font = UIFont(name: "Roboto-Regular", size: 12)

        descriptionLabel
            .top(to: .bottom, of: titleLabel)
            .left(to: .right(16), of: contentImageView).right(16)

        priceLabel.font = UIFont(name: "Roboto-Regular", size: 14)
        priceLabel.text = "9000"

        priceLabel
            .bottom(31)
            .left(to: .right(16), of: contentImageView)
        addToCartButton
            .top(to: .top, of: priceLabel)
            .bottom(31)
            .left(to: .right(16), of: priceLabel).right(16)
        addToCartButton.setTitleColor(.systemBlue, for: .normal)
        addToCartButton.setImage(UIImage(systemName: "cart"), for: .normal)
        addToCartButton.setTitle("Купить", for: .normal)

        separatorView.backgroundColor = Asset.fieldBacground.color
        separatorView.bottom().left(16).right(16).height(1)
    }
}
