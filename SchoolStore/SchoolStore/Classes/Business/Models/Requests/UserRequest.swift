// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

enum UserRequest: Request {
    case login(user: String, password: String)
    case user
    case changeProfile(name: String, surname: String, occupation: String, avatar: String)

    // MARK: Internal

    var path: String {
        switch self {
        case .login:
            return "user/signin"
        case .user, .changeProfile:
            return "user"
        }
    }

    var method: RequestMethod {
        switch self {
        case .login:
            return .put
        case .user:
            return .get
        case .changeProfile:
            return .patch
        }
    }
    
    var body: Data? {
             switch self {
             case let .login(user, password):
                return RequestBuilderImpl.encode(["login": user, "password": password])
             case let .changeProfile(name, surname, occupation, avatar):
                return RequestBuilderImpl.encode(["name": name, "surname": surname, "occupation": occupation, "avatar": avatar])
             default:
                return nil
             }
         }

    var mock: Data? {
        switch self {
        case .login:
            guard let path = Bundle.main.path(forResource: "auth", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            else {
                return nil
            }
            return data
        case .user:
            guard let path = Bundle.main.path(forResource: "user", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            else {
                return nil
            }
            return data
        case .changeProfile:
            guard let path = Bundle.main.path(forResource: "changeProfile", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            else {
                return nil
            }
            return data
        }
    }
}
