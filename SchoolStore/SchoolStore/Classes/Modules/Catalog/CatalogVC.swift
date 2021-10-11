// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import AutoLayoutSugar
import Foundation
import UIKit

// MARK: - CatalogVC

final class CatalogVC: UIViewController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.top().left().right().bottom()

        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            self?.items = [
                "Ботинок", "Шлепанец", "Телогрейка", "Трофейный ремень Вермахта", "Кожанка"
            ]
            self?.tableView.reloadData()
        }
    }

    // MARK: Internal

    static let productCellReuseId: String = ProductCell.description()

    var items: [String] = []

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
        return cell
    }
}
