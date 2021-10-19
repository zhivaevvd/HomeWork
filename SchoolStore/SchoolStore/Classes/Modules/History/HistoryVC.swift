// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit
import Foundation
import AutoLayoutSugar

final class HistoryVC: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.register(HistoryCell.self, forCellReuseIdentifier: Self.historyCellReuseId)
        
        return tableView
    }()
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.top(to: .bottom, of: segmentedControl).left().right().bottom()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [weak self] in
                self?.items = [
                        "sad", "asd", "etwtw", "12324", "safds"
                    ]
                self?.tableView.reloadData()
                })
        
        segmentedControl.addTarget(self, action: #selector(selectSegment), for: .valueChanged)
    }
    
    @objc
    func selectSegment(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [weak self] in
                    self?.items = [
                            "sad", "asd", "etwtw", "12324", "safds"
                        ]
                    self?.tableView.reloadData()
                    })
        } else if segment.selectedSegmentIndex == 1 {
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: { [weak self] in
                    self?.items = [
                            "sad", "asd"
                        ]
                    self?.tableView.reloadData()
                    })
        }
    }
    
    static let historyCellReuseId: String = HistoryCell.description()
    
    var items: [String] = []
    
}

extension HistoryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.historyCellReuseId, for: indexPath) as? HistoryCell else {
                return UITableViewCell()
            }
            
        cell.model = items[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertController = UIAlertController(title: "Вы точно хотите удалить запись?", message: nil, preferredStyle: .alert)
             
            let DeleteAction = UIAlertAction(title: "Удалить", style: .default) { (action) -> Void in
                self.items.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                }
                 
            let CloseAction = UIAlertAction(title: "Отмена", style: .default) { (action) -> Void in return }
               
                alertController.addAction(DeleteAction)
                alertController.addAction(CloseAction)
               
            self.present(alertController, animated: true, completion: nil)
        
        }
    }
}

