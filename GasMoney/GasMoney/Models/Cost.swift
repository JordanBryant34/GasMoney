//
//  Cost.swift
//  GasMoney
//
//  Created by Owen Gaudio on 11/17/20.
//

import Foundation

class Cost {
    var title: String
    var ammount: Double
    var description: String?
    
    init(title: String, ammount: Double, description: String? = nil){
        self.title = title
        self.ammount = ammount
        self.description = description
    }
}
