//
//  User.swift
//  GasMoney
//
//  Created by Owen Gaudio on 11/17/20.
//

import Foundation

class User {
    let username: String
    let profilePicURL: String
    var trips: [String]
    
    init(username: String, profilePicURL: String, trips: [String] = []){
        self.username = username
        self.profilePicURL = profilePicURL
        self.trips = trips
    }
}
