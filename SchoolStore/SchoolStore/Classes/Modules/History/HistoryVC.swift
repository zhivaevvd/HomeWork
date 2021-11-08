// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit
import AutoLayoutSugar

final class HistoryVC: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.History.title
        
        view.addSubview(tableView)
        tableView.top(to: .bottom, of: segmentedControl).left().right().bottom()
        configTableView()
        
        segmentedControl.height(44)
        segmentedControl.setTitle(L10n.SegmentedControl.all, forSegmentAt: 0)
        segmentedControl.setTitle(L10n.SegmentedControl.active, forSegmentAt: 1)
        segmentedControl.addTarget(self, action: #selector(selectCategory(_:)), for: .allEvents)
        segmentedControl.selectedSegmentIndex = 0
        getItems(index: segmentedControl.selectedSegmentIndex)
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
        tableView.register(HistoryCell.self, forCellReuseIdentifier: Self.historyCellReuseId)
        return tableView
    }()
    
    @objc
    func selectCategory(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            getItems(index: sender.selectedSegmentIndex)
        case 1:
            getItems(index: sender.selectedSegmentIndex)
        default:
            break
        }
    }
    
    private func getItems(index: Int) {
        historyService?.getHistoryItems(with: 0, limit: 20, completion: {
            [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case let .success(products):
                if index == 0 {
                    self.items = products
                    
                } else {
                    self.items = []
                    for product in products {
                        if product.status == .inWork {
                            self.items.append(product)
                        }
                    }
                }
                
                self.snapshot(Array(Set(self.items)))
            case .failure:
                break
            }
        })
    }
    
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
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let deleteAction = UITableViewRowAction(style: .destructive, title: L10n.Action.delete) { (_, indexPath) in
//            self.items.remove(at: indexPath.row)
//        }
//
//        if self.items[indexPath.row].status == .inWork {
//            return nil
//        } else {
//            return [deleteAction]
//        }
//
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let contextItem = UIContextualAction(style: .destructive, title: L10n.Action.delete) {  (_, _, _) in
            print(self.items[indexPath.row].id)
            self.historyService?.removeHistoryItem(orderId: self.items[indexPath.row].id, completion: {
                (result: Result<String, Error>) in
                switch result {
                case .success:
                    self.items.remove(at: indexPath.row)
                case .failure:
                    print("fail")
                }
            })
        }

        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        return swipeActions
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        if self.items[indexPath.row].status == .inWork {
//            return false
//        } else {
//            return true
//        }
//    }

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



