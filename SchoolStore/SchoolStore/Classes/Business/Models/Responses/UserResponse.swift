// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct UserResponse: Decodable {
    let accessToken: String
    let profile: Profile
}

struct GetUserResponse: Decodable {
    let user: Profile
}

struct ChangeUserResponse: Decodable {
    let changedUser: Profile
}


