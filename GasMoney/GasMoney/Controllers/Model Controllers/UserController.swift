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
    
    static func logoutUser() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
     
}
