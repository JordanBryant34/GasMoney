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
    var totalCost: Double
    var description: String?
    var costs: [Cost]
    
    init(name: String, id: String, destination: String, origin: String, participants: [User] = [], totalCost: Double = 0, description: String? = nil, costs: [Cost] = []){
        self.name = name
        self.id = id
        self.destination = destination
        self.origin = origin
        self.participants = participants
        self.totalCost = totalCost
        self.description = description
        self.costs = costs
    }
}
