//
//  UserController.swift
//  GasMoney
//
//  Created by Owen Gaudio on 11/17/20.
//

import Foundation
import FirebaseAuth

class UserController {
    
    static func loginUser(email: String, password: String, completion: @escaping (Result<Bool, AuthError>) -> Void) {
            Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
                if let error = error {
                    let errorCode = (error as NSError).code

                    if errorCode == 17008 {
                        print("Invalid email address")
                        completion(.failure(.thrownError(error)))
                        return
                    } else if errorCode == 17011 {
                        print("No user with that email exists")
                        completion(.failure(.thrownError(error)))
                        return
                    } else if errorCode == 17009 {
                        print("Incorrect password")
                        completion(.failure(.thrownError(error)))
                        return
                    } else {
                        print("Something went wrong")
                        completion(.failure(.thrownError(error)))
                        return
                    }

                } else {
                    print("Welcome back")
                    completion(.success(true))
                    return
                }
            }
        }
    
    func logoutUser() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    func createUser(email: String, password: String, confirmPassword: String, completion: @escaping (Result<Bool, AuthError>) -> Void) {
        
        if password.count < 8 || password.count > 30 {
            completion(.failure(.invalidPasswordLength))
            return
        }
        
        if password != confirmPassword {
            completion(.failure(.passwordsDontMatch))
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (_, error) in
            if let error = error {
                let errorCode = (error as NSError).code

                if errorCode == 17008 {
                    print("Invalid email address")
                    completion(.failure(.thrownError(error)))
                    return
                } else {
                    print("Something went wrong")
                    completion(.failure(.thrownError(error)))
                    return
                }

            } else {
                print("User created successfully")
                completion(.success(true))
                return
            }
        }
    }
    
    func setupProfile(username: String, profilePicURL: String) {
        if username.count < 6 || username.count > 16 {
            print("Error: Password is need to be between 6 and 16 characters")
            return
        }

        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = username
        changeRequest?.commitChanges(completion: { (error) in
            if let error = error {
                print(error.localizedDescription)
                print("Error: Something went wrong, please try again later")
                return
            }
        })
    }
    
    func fetchUser() {
    }
}
