//
//  TripController.swift
//  GasMoney
//
//  Created by Owen Gaudio on 11/17/20.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class TripController {
    
    static let ref = Database.database().reference()
    
    static func fetchUsersTrips(completion: @escaping ([Trip]) -> Void) {
        guard let currentUser = Auth.auth().currentUser?.displayName else { completion([]); return}
        var trips: [Trip] = []
        
        ref.child("users").child(currentUser).child("trips").observeSingleEvent(of: .value) { (snapshot) in
            guard let tripsDictionary = snapshot.value as? [String : Any] else { return completion(trips) }
            let dispatchGroup = DispatchGroup()
            
            for key in tripsDictionary.keys {
                dispatchGroup.enter()
                fetchTrip(id: key) { (trip) in
                    if let trip = trip {
                        trips.append(trip)
                    }
                    
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(trips)
            }
    
        }
    }
    
    static func fetchTrip(id: String, completion: @escaping (Trip?) -> Void) {
        let tripRef = ref.child("trips").child(id)
        
        tripRef.observeSingleEvent(of: .value) { (snapshot) in
            guard let tripDictionary = snapshot.value as? [String : Any] else { return completion(nil) }
            
            completion(Trip(dictionary: tripDictionary))
        }
    }
    
    static func createNewTrip(trip: Trip) {
        guard let currentUser = Auth.auth().currentUser?.displayName else { return }
    
        trip.participants.append(currentUser)
        
        for participant in trip.participants {
            ref.child("users").child(participant).child("trips").updateChildValues([trip.id : 1])
        }
        
        ref.child("trips").child(trip.id).updateChildValues(trip.dictionary())
    }
    
}
