// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit
import AutoLayoutSugar

class AuthVC: UIViewController {
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        localizable()
        
        signInButton.layer.cornerRadius = 8
        signInButton.addSubview(indicator)
        indicator.topAnchor.constraint(equalTo: signInButton.topAnchor).activate()
        indicator.centerX().centerY()
    }

    private lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .white
        return indicator
    }()

    // MARK: Internal

    @IBOutlet var loginField: InputField!

    @IBOutlet var passwordField: InputField!

    @IBOutlet var signInButton: UIButton!

    func setup(with profileService: ProfileService, _ snacker: Snacker) {
        self.profileService = profileService
        self.snacker = snacker
    }

    @IBAction func signInPressed(_: Any) {
        guard let user = loginField.text, let password = passwordField.text else {
            return
        }
        if user.isEmpty {
            loginField.error = L10n.Common.emptyField
        } else if password.isEmpty {
            passwordField.error = L10n.Common.emptyField
        } else {
            profileService?.authenticate(user: user, with: password, completion: { [weak self] (result: Result<String, Error>) in
                switch result {
                case .success:
                    self!.indicator.startAnimating()
                    self!.signInButton.setTitle("", for: .normal)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController = VCFactory.buildTabBarVC()
                    })
                case let .failure(error):
                    self?.handle(error: error)
                    self!.indicator.stopAnimating()
                }
            })
        }
    }

    // MARK: Private

    private var snacker: Snacker?

    private var profileService: ProfileService?

    private func handle(error: Error) {
        snacker?.show(snack: error.localizedDescription, with: .error)
        if let networkError = error as? Errors {
            switch networkError {
            case let .failedResponse(_, fields):
                fields?.forEach { field in
                    switch field.field {
                    case "login":
                        self.loginField.error = field.message
                    default:
                        break
                    }
                }
            default:
                break
            }
        }
    }

    private func localizable() {
        loginField.title = L10n.Auth.login
        passwordField.title = L10n.Auth.password
        signInButton.setTitle(L10n.Auth.action, for: .normal)
    }
}
