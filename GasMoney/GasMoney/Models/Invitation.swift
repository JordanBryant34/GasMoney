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
    let tripID: String
    
    init(username: String, id: String, tripName: String, tripID: String){
        self.username = username
        self.id = id
        self.tripName = tripName
        self.tripID = tripID
    }
}

extension Invitation {
    
    convenience init?(dictionary: [String: Any]) {
        guard let username = dictionary["username"] as? String else { return nil }
        guard let tripName = dictionary["tripName"] as? String else { return nil }
        guard let id = dictionary["id"] as? String else { return nil }
        guard let tripID = dictionary["tripID"] as? String else { return nil }
        
        self.init(username: username, id: id, tripName: tripName, tripID: tripID)
    }
    
    func dictionary() -> [String : Any] {
        var dictionary: [String : Any] = [:]
        
        dictionary["username"] = username
        dictionary["tripName"] = tripName
        dictionary["id"] = id
        dictionary["tripID"] = tripID
        
        return dictionary
    }
}
