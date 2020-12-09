//
//  Invitation.swift
//  GasMoney
//
//  Created by Owen Gaudio on 11/30/20.
//

import Foundation

class Invitation {
    let username: String
    let id: String
    let tripName: String
    
    init(username: String, id: String, tripName: String){
        self.username = username
        self.id = id
        self.tripName = tripName
    }
}

extension Invitation {
    
    convenience init?(dictionary: [String: Any]) {
        guard let username = dictionary["username"] as? String else { return nil }
        guard let tripName = dictionary["tripName"] as? String else { return nil }
        guard let id = dictionary["id"] as? String else { return nil }
        
        self.init(username: username, id: id, tripName: tripName)
    }
    
}
