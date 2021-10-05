//
//  CatalogVC.swift
//  SchoolStore
//
//  Created by a1 on 30.09.2021.
//

import UIKit

class CatalogVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setup(with catalogService: CatalogService) {
        self.catalogService = catalogService
    }
    
    private var catalogService: CatalogService?

}
