//
//  InvitationController.swift
//  GasMoney
//
//  Created by Owen Gaudio on 12/9/20.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class InvitationController {
    static let ref = Database.database().reference()
    
    static func addParticipants(trip: Trip, participants: [String]) {
        guard let currentUser = Auth.auth().currentUser?.displayName else { return }
        for person in participants {
            let id = randomString(length: 25)
            let invitation = Invitation(username: currentUser, id: id, tripName: trip.name, tripID: trip.id)
            let invitationDictionary = invitation.dictionary
            ref.child("users").child(person).child("invitations").updateChildValues(invitationDictionary())
        }
    }
    
    static func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    static func fetchInvitations(completion: @escaping ([Invitation]) -> Void) {
        guard let currentUser = Auth.auth().currentUser?.displayName else {return completion([])}
        
        ref.child("users").child(currentUser).child("invitations").observeSingleEvent(of: .value) { (snapshot) in
            guard let invitationsDictionary = snapshot.value as? [String: Any] else { return completion([])}
            let keys = invitationsDictionary.keys
            var invitations: [Invitation] = []
            for key in keys {
                if let invitationDictionary = invitationsDictionary[key] as? [String : Any] {
                    guard let invitation = Invitation(dictionary: invitationDictionary) else {return completion([])}
                    invitations.append(invitation)
                }
            }
            return completion(invitations)
        }
    }
    
    static func acceptInvitation(invitation: Invitation) {
        guard let currentUser = Auth.auth().currentUser?.displayName else { return }
        let tripID = invitation.tripID
        ref.child("users").child(currentUser).child("trips").updateChildValues([tripID : (Any).self])
        ref.child("trips").child(tripID).child("participants").updateChildValues([currentUser : (Any).self])
        removeInvitation(invitation: invitation)
    }
    
    static func removeInvitation(invitation: Invitation) {
        let inviteID = invitation.id
        guard let currentUser = Auth.auth().currentUser?.displayName else { return }
        ref.child("users").child(currentUser).child("invitations").child(inviteID).removeValue()
    }
    
}
