//
//  User.swift
//  GasMoney
//
//  Created by Owen Gaudio on 11/17/20.
//

import Foundation

class User {
    
    let username: String
    var trips: [String]
    
    init(username: String, trips: [String] = []){
        self.username = username
        self.trips = trips
    }
    
}

extension User {
    
    convenience init?(dictionary: [String: Any]) {
        guard let username = dictionary["username"] as? String else { return nil }
        
        var trips: [String] = []
        if let tripsDictionary = dictionary["trips"] as? [String : Any] {
            trips = Array(tripsDictionary.keys)
        }
        
        self.init(username: username, trips: trips)
    }
    
}
