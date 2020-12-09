//
//  CostController.swift
//  GasMoney
//
//  Created by Owen Gaudio on 11/17/20.
//

import Foundation
import FirebaseDatabase

class CostController {
    
    static let ref = Database.database().reference()
    
    static func saveCost(cost: Cost, to trip: Trip) {
        let tripRef = ref.child("trips").child(trip.id).child("costs")
        
        tripRef.childByAutoId().updateChildValues([
            "title" : cost.title,
            "amount" : cost.amount
        ])
    }
    
}
