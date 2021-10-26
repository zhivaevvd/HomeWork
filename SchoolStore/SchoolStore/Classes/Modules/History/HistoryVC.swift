// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit
import SwiftUI

final class HistoryVC: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.History.title
        
        view.addSubview(tableView)
        tableView.top(to: .bottom, of: segmentedControl).left().right().bottom()
        configTableView()
        historyService?.getHistoryItems(with: 0, limit: 20, completion: { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(products):
                self.items = products
            case .failure:
                break
            }
        })
    }
    
    static let historyCellReuseId: String = HistoryCell.description()
    
    var historyService: HistoryService?

    var snacker: Snacker?
    
    var items: [Order] = [] {
        didSet {
            snapshot(Array(Set(items)))
        }
    }
    
    private enum SimpleDiffableSection: Int, Hashable {
        case main
    }
    
    
    private var dataSource: UITableViewDiffableDataSource<SimpleDiffableSection, Order>?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.register(HistoryCell.self, forCellReuseIdentifier: Self.historyCellReuseId
        )
        return tableView
    }()
    
    func configTableView() {
        dataSource = UITableViewDiffableDataSource<SimpleDiffableSection, Order>(
            tableView: tableView,
            cellProvider: { tableView, indexPath, model -> UITableViewCell? in
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: Self.historyCellReuseId,
                    for: indexPath
                ) as? HistoryCell else {
                    return nil
                }
                cell.model = model
                return cell
            }
        )
    }
    
    func loadFooterView(load: Bool) {
        if load {
            let view = UIView()
            view.frame.size = .init(width: view.frame.size.width, height: 60)
            view.startLoading(with: .smallBlue)
            tableView.tableFooterView = view
        } else {
            tableView.tableFooterView = UIView()
        }
    }
    
    func snapshot(_ items: [Order]) {
        var snapshot = NSDiffableDataSourceSnapshot<SimpleDiffableSection, Order>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func loadNextPage() {
        isLoadingNextPage = true
        historyService?.getHistoryItems(with: items.count, limit: 12, completion: { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case let .success(orders):
                self.items += orders
            case .failure:
                break
            }
            self.isLoadingNextPage = false
        })
    }
    
    private var isLoadingNextPage: Bool = false {
        didSet {
            loadFooterView(load: isLoadingNextPage)
        }
    }
}

extension HistoryVC: UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate _: Bool) {
        guard !isLoadingNextPage else { return }
        let offset = scrollView.contentOffset.y
        let height = scrollView.frame.size.height
        let contentHeight = scrollView.contentSize.height

        if scrollView == tableView {
            if (offset + height) >= contentHeight {
                loadNextPage()
            }
        }
    }
}


