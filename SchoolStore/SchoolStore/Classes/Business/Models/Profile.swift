// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct Profile: Decodable, Hashable, Equatable {
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: CodingKeys.name)
//        surname = try container.decode(String.self, forKey: CodingKeys.surname)
//        occupation = try container.decode(String.self, forKey: CodingKeys.occupation)
//        avatarUrl = try container.decode(String?.self, forKey: CodingKeys.avatarUrl)
//    }
//
//    enum CodingKeys: String, CodingKey {
//        case name, surname, occupation, avatarUrl
//    }
    
    let name: String
    let surname: String
    let occupation: String
    let avatarUrl: String?
}
