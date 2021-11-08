//
//  HistoryCell.swift
//  SchoolStore
//
//  Created by a1 on 21.10.2021.
//

import AutoLayoutSugar
import Foundation
import Kingfisher
import UIKit

final class HistoryCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    var model: Order? {
        didSet{
            if let preview = model?.productPreview, let previewUrl = URL(string: preview) {
                let contentImageResource = ImageResource(downloadURL: previewUrl, cacheKey: preview)
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
            
            guard let date = model?.createdAt,
                  let orderNum = model?.number,
                  let status = model?.status,
                  let title = model?.title,
                  let productQuantity = model?.productQuantity,
                  let productSize = model?.productSize,
                  let etd = model?.etd,
                  let deliveryAddress = model?.deliveryAddress
            else {
                return
            }
            
            let formatter = ISO8601DateFormatter()
            let tmp = formatter.date(from: date)
            let tmp1 = formatter.date(from: etd)
            
            guard let stringDate = tmp?.stringDate,
                  let stringEtd = tmp1?.stringDate
            else {
                return
            }
            
            orderNumber.text = "\(L10n.OrderNumber.title)" + String(orderNum) + " \(L10n.Common.from) " + stringDate
            
            switch status {
            case .inWork:
                statusLabel.text = L10n.OrderInWork.title
                statusLabel.textColor = .systemGreen
            case .done:
                break
            case .cancelled:
                statusLabel.text = L10n.OrderCancelled.title
                statusLabel.textColor = .red
            }
            
            orderDescription.text = "\(productQuantity) × " + "\(productSize) · " + title
            deliveryLabel.text = "\(L10n.DeliveryDate.title) : \(stringEtd)" + "\n\(L10n.Address.title): \(deliveryAddress)"
        }
    }
    
    private lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Asset.itemPlaceholder.image
        return imageView
    }()
    
    private lazy var orderNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = Asset.textPrimary.color
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var orderDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var deliveryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textColor = .gray
        label.alpha = 0.8
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()

    private func setup() {
        selectionStyle = .none
        contentView.addSubview(contentImageView)
        contentView.addSubview(orderNumber)
        contentView.addSubview(statusLabel)
        contentView.addSubview(orderDescription)
        contentView.addSubview(deliveryLabel)
        contentView.addSubview(separatorView)
        
        contentImageView.top(16).left(16).width(63.02).height(64).bottom(69)
        orderNumber.top(16).left(to: .right(8), of: contentImageView).height(12)
        
        statusLabel.top(to: .bottom(8), of: orderNumber).left(to: .right(8), of: contentImageView).width(203).height(17)
        
        orderDescription.top(to: .bottom(8), of: statusLabel).left(to: . right(8), of: contentImageView).width(257)
        
        deliveryLabel.top(to: .bottom(8), of: orderDescription).left(to: .right(8), of: contentImageView).width(257)
        
        separatorView.bottom().left(16).right(16).height(1)
        
        separatorView.backgroundColor = Asset.fieldBacground.color
        separatorView.bottom().left(16).right(16).height(1)
    }
}

extension Date {

    var stringDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy '\(L10n.Common.in)' hh:mm"
        return formatter.string(from: self)
    }

}
