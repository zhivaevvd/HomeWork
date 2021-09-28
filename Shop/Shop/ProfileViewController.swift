//
//  ProfileViewController.swift
//  Shop
//
//  Created by a1 on 28.09.2021.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logOut(_ sender: Any) {
        let window = UIApplication.shared.windows.first{
            $0.isKeyWindow
        }
        
        if let vc: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() {
            window?.rootViewController = vc
        }
    }
}
