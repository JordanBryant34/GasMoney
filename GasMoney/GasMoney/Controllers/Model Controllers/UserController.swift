//
//  UserController.swift
//  GasMoney
//
//  Created by Owen Gaudio on 11/17/20.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class UserController {
    
    static let ref = Database.database().reference()
    
    static func loginUser(email: String, password: String, completion: @escaping (Result<Bool, AuthError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            if let error = error {
                let errorCode = (error as NSError).code
                
                if errorCode == 17008 {
                    Helpers.showNotificationBanner(title: "Invalid email address", subtitle: "Please check that the email address is correct and try again.", image: nil, style: .danger, textAlignment: .left)
                    completion(.failure(.thrownError(error)))
                    return
                } else if errorCode == 17011 {
                    Helpers.showNotificationBanner(title: "No user with that email exists", subtitle: "This email address is currently not in use by Gas Money.", image: nil, style: .danger, textAlignment: .left)
                    completion(.failure(.thrownError(error)))
                    return
                } else if errorCode == 17009 {
                    Helpers.showNotificationBanner(title: "Incorrect password", subtitle: "Please double check the password and try again.", image: nil, style: .danger, textAlignment: .left)
                    completion(.failure(.thrownError(error)))
                    return
                } else {
                    Helpers.showNotificationBanner(title: "Something went wrong", subtitle: "Please try again later.", image: nil, style: .danger, textAlignment: .left)
                    completion(.failure(.thrownError(error)))
                    return
                }
                        
            } else {
                completion(.success(true))
                return
            }
        }
    }
    
    static func createNewUser(username: String, email: String, password: String, completion: @escaping (Result<Bool, AuthError>) -> Void) {
        
        if (password.count < 8) || (password.count > 30) {
            Helpers.showNotificationBanner(title: "Invalid password length", subtitle: "Passwords have to be 8 to 30 characters long.", image: nil, style: .danger, textAlignment: .left)
            completion(.failure(.invalidPasswordLength))
            return
        }
        
        if username.range(of: "[^a-zA-Z0-9]", options: .regularExpression) != nil {
            Helpers.showNotificationBanner(title: "Invalid username", subtitle: "Usernames can only contain alphanumeric characters.", image: nil, style: .danger, textAlignment: .left)
            completion(.failure(.invalidUsername))
            return
        } else if username.count < 6 || username.count > 15 {
            Helpers.showNotificationBanner(title: "Invalid username", subtitle: "Usernames have to be between 6 and 15 characters.", image: nil, style: .danger, textAlignment: .left)
            completion(.failure(.invalidUsername))
            return
        }
        
        ref.child("users").child(username).observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                Helpers.showNotificationBanner(title: "Username is already in use", subtitle: "Choose a different username to continue.", image: nil, style: .danger, textAlignment: .left)
                completion(.failure(.invalidUsername))
            } else {
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        let errorCode = (error as NSError).code
                        
                        if errorCode == 17008 {
                            Helpers.showNotificationBanner(title: "Invalid email address", subtitle: "Please check that the email address is correct and try again.", image: nil, style: .danger, textAlignment: .left)
                            completion(.failure(.thrownError(error)))
                            return
                        } else if errorCode == 17007 {
                            Helpers.showNotificationBanner(title: "Email already in use", subtitle: "Sign in with the email address or use a new email.", image: nil, style: .danger, textAlignment: .left)
                            completion(.failure(.thrownError(error)))
                            return
                        }
                        
                        Helpers.showNotificationBanner(title: "Could not create account", subtitle: "An error has occurred. Please try again later.", image: nil, style: .danger, textAlignment: .left)
                        completion(.failure(.thrownError(error)))
                        return
                    }
                    
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = username

                    changeRequest?.commitChanges { (error) in
                        if let error = error {
                            Helpers.showNotificationBanner(title: "An error has occured", subtitle: "Something went wrong when setting your username. Please try again later.", image: nil, style: .danger, textAlignment: .left)
                            print(error.localizedDescription)
                            completion(.failure(.thrownError(error)))
                            return
                        }
                        
                        let values: [String : Any] = [
                            "dateJoined" : Int(NSDate().timeIntervalSince1970),
                            "username" : username,
                            "searchName" : username.lowercased(),
                        ]
                        
                        ref.child("users").child(username).updateChildValues(values)
                        
                        if Auth.auth().currentUser != nil {
                            completion(.success(true))
                        }
                    }
                }
                
            }
        }
    }
    
    static func logoutUser() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    static func fetchUser(username: String, completion: @escaping (User?) -> Void) {
        ref.child("users").child(username).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String : Any] else { return completion(nil) }
            
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func searchUsers(searchText: String, completion: @escaping (_ users: [User]) -> Void) {
        guard let currentUser = Auth.auth().currentUser?.displayName else { completion([]); return }
        let searchText = searchText.lowercased()
        Database.database().reference().child("users").queryOrdered(byChild: "searchName").queryStarting(atValue: searchText).queryEnding(atValue: searchText+"\u{f8ff}").observeSingleEvent(of: .value) { (snapshot) in
            var users: [User] = []
            
            guard let dictionary = snapshot.value as? [String : Any] else {
                completion(users)
                return
            }
            
            for key in dictionary.keys {
                if let userDictionary = dictionary[key] as? [String : Any], let user = User(dictionary: userDictionary), user.username != currentUser {
                    users.append(user)
                }
            }
            
            completion(users)
        }
    }
     
}
