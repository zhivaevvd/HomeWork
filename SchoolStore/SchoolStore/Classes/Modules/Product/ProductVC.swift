// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import AutoLayoutSugar
import Foundation
import UIKit
import Accelerate

final class ProductVC: UIViewController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToSuperview()
        contentView.pinToSuperview()
            .width(as: scrollView)
        
        scrollView
            .heightAnchor
            .constraint(lessThanOrEqualTo: contentView.heightAnchor)
            .activate()
        
        view.addSubview(buyButton)
        buyButton.setTitle(L10n.Product.buyNow, for: .normal)
        buyButton.setTitleColor(UIColor.white, for: .normal)
        buyButton.backgroundColor = .systemBlue
        buyButton.layer.cornerRadius = 8
        buyButton.bottom(100).left(16).right(16).height(44)
        
        view.addSubview(backButton)
        backButton.setTitle(L10n.Common.back, for: .normal)
        backButton.setTitleColor(UIColor.systemBlue, for: .normal)
        backButton.left(10).top(50)
        backButton.setImage(UIImage.init(systemName: "chevron.backward"), for: .normal)
        
        backButton.addTarget(self, action: #selector(returnToCatalog), for: .touchUpInside)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc
    func returnToCatalog() {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?
            .rootViewController = VCFactory.buildTabBarVC()
    }

    // MARK: Internal

    var product: Product? {
        didSet {
            contentView.fillWith(product: product)
        }
    }

    // MARK: Private

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private lazy var contentView: ProductView = {
        let contentView = ProductView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToCheckoutVC), for: .touchUpInside)
        return button
    }()
    
    @objc
    func goToCheckoutVC() {
        guard let product = product else {
            return
        }

        self.navigationController?.pushViewController(VCFactory.buildCheckoutVC(with: product), animated: true)
    }
}
