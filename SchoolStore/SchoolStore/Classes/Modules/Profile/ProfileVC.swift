// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit
import AutoLayoutSugar
import Kingfisher

class ProfileVC: UIViewController {
    // MARK: Lifecycle
    
    private var profile: Profile?

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.selectedItem?.title = L10n.Profile.title

        profileService?.getProfile(completion: {
            (result: Result<Profile, Error>) in
            switch result {
            case let .success(pr):
                self.profile = pr
            case let .failure(error):
                print(error)
            }
        })
        
        view.addSubview(contentView)
        contentView.height(166).left().right()
        contentView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).activate()
        
        contentView.addSubview(imageView)
        imageView.centerX().top().width(90).height(90)
        imageView.layer.cornerRadius = 45
        imageView.clipsToBounds = true
        
        contentView.addSubview(userNameLabel)
        userNameLabel.top(to: .bottom(16), of: imageView).left(74).right(74)
        
        guard let name = profile?.name,
              let surname = profile?.surname,
              let occupation = profile?.occupation
        else {
            return
        }
        
        userNameLabel.left(74).right(74).height(26)
        userNameLabel.textColor = .white
        userNameLabel.text = name + " " + surname
        
        contentView.addSubview(occupationLabel)
        occupationLabel.left(136.5).right(136.5).top(to: .bottom, of: userNameLabel)
        
        occupationLabel.text = occupation
    
        view.addSubview(stackView)
       
        stackView.top(to: .bottom(20), of: contentView).height(100).centerX()
        
        stackView.addArrangedSubview(ordersButton)
        stackView.addArrangedSubview(settingsButton)
        stackView.addArrangedSubview(logoutButton)
        
        ordersButton.addSubview(ordersLabel)
        ordersLabel.top(to: .bottom, of: ordersButton.imageView).bottom(to: .bottom(1), of: ordersButton).centerX()
        
        settingsButton.addSubview(settingsLabel)
        settingsLabel.top(to: .bottom, of: settingsButton.imageView).left().right().bottom(to: .bottom(1), of: settingsButton).centerX()
        
        logoutButton.addSubview(exitLabel)
        exitLabel.top(to: .bottom, of: logoutButton.imageView).left().right().bottom(to: .bottom(1), of: logoutButton).centerX()
        
        logoutButton.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
        ordersButton.addTarget(self, action: #selector(ordersButtonPressed), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed), for: .touchUpInside)
        
        if let preview = profile?.avatarUrl, let previewUrl = URL(string: preview) {
            let contentImageResource = ImageResource(downloadURL: previewUrl, cacheKey: preview)
            imageView.kf.setImage(
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
            imageView.image = Asset.itemPlaceholder.image
        }
        
    }
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Asset.navBlue.color
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = Asset.imagePlaceholder.image
        return iv
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var occupationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.height(18)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 16.0
        return sv
    }()
    
    private lazy var ordersButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.lineBreakMode = .byWordWrapping
        btn.contentHorizontalAlignment = .center
        btn.backgroundColor = .systemGray5
        
        var image = UIImage(systemName: "book.fill")
        image = image?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(image, for: .normal)
        btn.tintColor = .black
        btn.width(110)
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    private lazy var settingsButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .systemGray5
        
        var image = UIImage(systemName: "gearshape.2.fill")
        image = image?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(image, for: .normal)
        btn.tintColor = .black
        btn.width(110)
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    private lazy var logoutButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .systemRed
        
        var image = UIImage(systemName: "arrowshape.turn.up.right.fill")
        image = image?.withRenderingMode(.alwaysTemplate)
        
        btn.setImage(image, for: .normal)
        btn.tintColor = .white
        btn.width(110)
        btn.layer.cornerRadius = 12
        return btn
    }()
    
    private lazy var ordersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.Profile.myOrders
        return label
    }()
    
    private lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.Settings.title
        label.textAlignment = .center
        return label
    }()
    
    private lazy var exitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = L10n.Profile.exit
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    @objc
    func logoutPressed() {
        dataService?.appState.accessToken = nil
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController = VCFactory.buildAuthVC()
    }
    
    @objc
    func ordersButtonPressed() {
        self.tabBarController?.selectedIndex = 1
    }
    
    @objc
    func settingsButtonPressed() {
        guard let profile = self.profile else {
            return
        }

        self.navigationController?.pushViewController(VCFactory.buildSettingsVC(with: profile), animated: true)
    }
    
    func setup(with profileService: ProfileService, _ snacker: Snacker, dataService: DataService) {
        self.profileService = profileService
        self.snacker = snacker
        self.dataService = dataService
    }
    
    private var profileService: ProfileService?
    
    private var snacker: Snacker?
    
    private var dataService: DataService?
}
