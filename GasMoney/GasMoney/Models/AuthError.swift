//
//  AuthError.swift
//  GasMoney
//
//  Created by Owen Gaudio on 11/17/20.
//

import Foundation

enum AuthError: LocalizedError {
    case thrownError(Error)
    case invalidPasswordLength
    case passwordsDontMatch
    
    var errorDescription: String? {
        switch self {
        case .invalidPasswordLength:
            return "Password must be between 8 and 30 characters."
        case .passwordsDontMatch:
            return "Passwords do not match."
        case .thrownError(let error):
            return error.localizedDescription
        }
    }
}
