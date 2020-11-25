//
//  Cost.swift
//  GasMoney
//
//  Created by Owen Gaudio on 11/17/20.
//

import Foundation

class Cost {
    
    var title: String
    var amount: Double
    var description: String?
    
    init(title: String, amount: Double, description: String? = nil){
        self.title = title
        self.amount = amount
        self.description = description
    }
    
}

extension Cost {
    
    convenience init?(dictionary: [String: Any]) {
        guard let title = dictionary["title"] as? String else { return nil }
        guard let amount = dictionary["amount"] as? Double else { return nil }
        let description = dictionary["description"] as? String
        
        self.init(title: title, amount: amount, description: description)
    }
    
}
