//
//  RoundedButton.swift
//  GasMoney
//
//  Created by Jordan Bryant on 11/18/20.
//

import UIKit

class RoundedButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.masksToBounds = true
        layer.cornerRadius = frame.height / 2
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
