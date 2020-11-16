//
//  TripCell.swift
//  GasMoney
//
//  Created by Kaleb  Carrizoza on 11/16/20.
//

import UIKit

class TripCell: UICollectionViewCell {
    
    let mapImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "TestMapImage")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let detailView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Title Name"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let participantsLabel: UILabel = {
        let participantsLabel = UILabel()
        participantsLabel.text = "5 participants"
        participantsLabel.sizeToFit()
        participantsLabel.textColor = .subLabelGray()
        participantsLabel.font = UIFont.boldSystemFont(ofSize: 15)
        participantsLabel.translatesAutoresizingMaskIntoConstraints = false
        return participantsLabel
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        createShadow()
        
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(mapImageView)
        contentView.addSubview(detailView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(participantsLabel)
        
        mapImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mapImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        mapImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        mapImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6).isActive = true
        
        detailView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        detailView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        detailView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        detailView.topAnchor.constraint(equalTo: mapImageView.bottomAnchor, constant: -10).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 15).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        participantsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        participantsLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
 
    }
    
    private func createShadow() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
        backgroundColor = .white
        layer.cornerRadius = 10
        
    }
}
