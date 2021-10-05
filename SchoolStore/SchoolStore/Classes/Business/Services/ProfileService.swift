//
//  ProfileService.swift
//  SchoolStore
//
//  Created by a1 on 30.09.2021.
//

import Foundation

protocol ProfileService: AnyObject {
    func someFunc()
}

final class ProfileServiceIml: ProfileService {
    
    init() {}
    
    func someFunc() {}
}
