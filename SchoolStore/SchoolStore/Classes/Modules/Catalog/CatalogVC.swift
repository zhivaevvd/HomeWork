// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import AutoLayoutSugar
import Foundation
import UIKit

// MARK: - CatalogVC

final class CatalogVC: UIViewController {
    // MARK: Lifecycle

    var items: [Product] = []
    private var item: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.top().left().right().bottom()

        catalogService?.getListOfProducts(completion: {
            result in
            switch result {
            case let .success(products):
                self.items = products
                self.tableView.reloadData()
            case .failure(_):
                break
            }
        })

    }
    
    func setup(with catalogService: CatalogService, _ snacker: Snacker) {
        self.catalogService = catalogService
        self.snacker = snacker
    }

    // MARK: Internal

    static let productCellReuseId: String = ProductCell.description()

    // MARK: Private

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            ProductCell.self,
            forCellReuseIdentifier: Self.productCellReuseId
        )
        return tableView
    }()
    
    private var catalogService: CatalogService?
    
    private var snacker: Snacker?
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension CatalogVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Self.productCellReuseId,
            for: indexPath
        ) as? ProductCell else {
            return UITableViewCell()
        }
        cell.model = items[indexPath.row]
        item = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController = VCFactory.buildDetailInfoVC(product: item!)
    }
}
