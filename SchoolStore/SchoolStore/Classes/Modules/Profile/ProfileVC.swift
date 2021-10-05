// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit
import TTGSnackbar

class ProfileVC: UIViewController {
    // MARK: Lifecycle

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

    // MARK: Internal
    
    func setup(with profileService: ProfileService) {
        self.profileService = profileService
    }

    @IBAction func logoutPressed(_: Any) {
        // TODO: Add service call here
        
        SnackbarFactory.buildLogOutSnackbar().show()
        
//        let dataService = DataServiceImpl()
//        dataService.appState.accessToken = nil
//
//        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController = VCFactory.buildAuthVC()
    }
    
    // MARK: Private
    
    private var profileService: ProfileService?
}
