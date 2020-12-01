//
//  InvitationCell.swift
//  GasMoney
//
//  Created by Owen Gaudio on 11/30/20.
//

import UIKit

class InvitationCell: UICollectionViewCell {
    
    let invitationLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "___ invited you to a trip!"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let destinationLabel: UILabel = {
        let destinationLabel = UILabel()
        destinationLabel.text = "nowhere"
        destinationLabel.textColor = .gasGray()
        destinationLabel.font = UIFont.systemFont(ofSize: 14)
        destinationLabel.translatesAutoresizingMaskIntoConstraints = false
        return destinationLabel
    }()
    
    let acceptButton: UIButton = {
        let viewButton = UIButton()
        let image = UIImage(named: "checkmark")?.resize(newSize: CGSize(width: 40, height: 40)).withRenderingMode(.alwaysTemplate)
        viewButton.tintColor = .gasGreen()
        viewButton.setImage(image, for: .normal)
        viewButton.translatesAutoresizingMaskIntoConstraints = false
        return viewButton
    }()
    
    let declineButton: UIButton = {
        let viewButton = UIButton()
        let image = UIImage(named: "declinemark")?.resize(newSize: CGSize(width: 25, height: 25)).withRenderingMode(.alwaysTemplate)
        viewButton.tintColor = .systemRed
        viewButton.setImage(image, for: .normal)
        viewButton.translatesAutoresizingMaskIntoConstraints = false
        return viewButton
    }()
    
    var invitation: Invitation? {
        didSet {
            setData()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        createShadow()
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(invitationLabel)
        contentView.addSubview(destinationLabel)
        contentView.addSubview(acceptButton)
        contentView.addSubview(declineButton)
        
        invitationLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        invitationLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        invitationLabel.rightAnchor.constraint(equalTo: acceptButton.leftAnchor, constant: -8).isActive = true
        invitationLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        destinationLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        destinationLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        destinationLabel.rightAnchor.constraint(equalTo: acceptButton.leftAnchor, constant: -8).isActive = true
        destinationLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true

        
        acceptButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        acceptButton.rightAnchor.constraint(equalTo: declineButton.leftAnchor, constant: -20).isActive = true
        acceptButton.setHeightAndWidthConstants(height: 40, width: 40)
        
        declineButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        declineButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        declineButton.setHeightAndWidthConstants(height: 25, width: 25)
    }
    
    private func setData() {
        guard let invitation = invitation else { return }
        
        invitationLabel.text = "\(invitation.username) has invited you to a trip!"
        destinationLabel.text = invitation.tripName
        
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

