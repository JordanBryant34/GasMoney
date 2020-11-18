//
//  TripController.swift
//  GasMoney
//
//  Created by Owen Gaudio on 11/17/20.
//

import Foundation

class TripController {
    
    func createTrip(name: String, id: String, destination: String, origin: String, participants: [User], totalCost: Double, description: String?, costs: [Cost]) -> Trip {
        let newTrip = Trip(name: name, id: id, destination: destination, origin: origin, participants: participants, totalCost: totalCost, description: description, costs: costs)
        return newTrip
    }
    
    func updateTrip(trip: Trip) -> Trip {
        let updatedTrip = trip
        return updatedTrip
    }
    
    func fetchTrips () {
        
    }
    
    
}
