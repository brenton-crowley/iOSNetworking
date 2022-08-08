//
//  UserProfile.swift
//  iOSNetworking
//
//  Created by Brent on 8/8/2022.
//

import Foundation

struct UserProfile: Decodable {
    
    var uuid, email, timezone: String
    var lastName, avatarUrl, firstName, fullName: String?
}
