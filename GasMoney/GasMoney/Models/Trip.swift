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
    var participants: [String]
    var description: String?
    var costs: [Cost]
    
    var totalCost: Double {
        return costs.map({$0.amount}).reduce(0, +)
    }
    
    init(name: String, id: String, destination: String, origin: String, participants: [String] = [], description: String? = nil, costs: [Cost] = []){
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
        
        var participantsArray: [String] = []
        if let participantsDict = dictionary["participants"] as? [String : Any] {
            let participants = Array(participantsDict.keys)
            participantsArray = participants
        }
        
        var costsArray: [Cost] = []
        if let costsDict = dictionary["costs"] as? [String : Any] {
            for key in costsDict.keys {
                if let costDict = costsDict[key] as? [String : Any], let cost = Cost(dictionary: costDict) {
                    costsArray.append(cost)
                }
            }
        }
        
        self.init(name: name, id: id, destination: destination, origin: origin, participants: participantsArray, description: description, costs: costsArray)
    }
    
}
