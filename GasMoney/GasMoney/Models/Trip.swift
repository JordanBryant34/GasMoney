//
//  Trip.swift
//  GasMoney
//
//  Created by Owen Gaudio on 11/17/20.
//

import Foundation

class Trip {
    
    var name: String
    let id: String
    var destination: String
    var origin: String
    var participants: [User]
    var description: String?
    var costs: [Cost]
    
    var totalCost: Double {
        return 0
    }
    
    init(name: String, id: String, destination: String, origin: String, participants: [User] = [], description: String? = nil, costs: [Cost] = []){
        self.name = name
        self.id = id
        self.destination = destination
        self.origin = origin
        self.participants = participants
        self.description = description
        self.costs = costs
    }

}

extension Trip {
    
    convenience init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String else { return nil }
        guard let destination = dictionary["destination"] as? String else { return nil }
        guard let origin = dictionary["origin"] as? String else { return nil }
        guard let id = dictionary["id"] as? String else { return nil }
        let description = dictionary["description"] as? String
        
        var participantsArray: [User] = []
        if let participantsDict = dictionary["participants"] as? [String : Any] {
            for key in participantsDict.keys {
                //TODO: instantiate users and add them to the participants array
            }
        }
        
        var costsArray: [Cost] = []
        if let costsDict = dictionary["costs"] as? [String : Any] {
            for key in costsDict.keys {
                //TODO: instantiate costs and add them to the costs array
            }
        }
        
        self.init(name: name, id: id, destination: destination, origin: origin, participants: participantsArray, description: description, costs: costsArray)
    }
    
}
