//
//  ProfileTableViewHeader.swift
//  GasMoney
//
//  Created by Kaleb  Carrizoza on 11/18/20.
//

import UIKit

class ProfileTableViewHeader: UITableViewHeaderFooterView {
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "Profile Header"
        label.textColor = .gasGreen()
        label.sizeToFit()
        label.font = .boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .white
        
        setupViews()
    }
    
    private func setupViews() {
        addSubview(label)
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
