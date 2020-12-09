//
//  CostTableViewCell.swift
//  GasMoney
//
//  Created by Jordan Bryant on 12/3/20.
//

import UIKit

class CostTableViewCell: UITableViewCell {
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gasGray()
        label.font = .boldSystemFont(ofSize: 20)
        label.sizeToFit()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let costNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gasGreen()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupViews()
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(priceLabel)
        contentView.addSubview(costNameLabel)
        
        priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        costNameLabel.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: priceLabel.leftAnchor, topConstant: 0, leftConstant: 15, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
    }
    
}
