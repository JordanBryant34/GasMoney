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
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    let participantsLabel: UILabel = {
        let participantsLabel = UILabel()
        participantsLabel.sizeToFit()
        participantsLabel.textColor = .subLabelGray()
        participantsLabel.font = UIFont.boldSystemFont(ofSize: 15)
        participantsLabel.translatesAutoresizingMaskIntoConstraints = false
        return participantsLabel
    }()
    
    private let destinationTitleLabel: UILabel = {
        let destinationLabel = UILabel()
        destinationLabel.text = "Destination"
        destinationLabel.textColor = .gasGreen()
        destinationLabel.font = UIFont.boldSystemFont(ofSize: 15)
        destinationLabel.translatesAutoresizingMaskIntoConstraints = false
        return destinationLabel
    }()
    
    let destinationLabel: UILabel = {
        let destinationLabel = UILabel()
        destinationLabel.textColor = .subLabelGray()
        destinationLabel.font = UIFont.boldSystemFont(ofSize: 13)
        destinationLabel.translatesAutoresizingMaskIntoConstraints = false
        return destinationLabel
    }()
    
    private let costTitleLabel: UILabel = {
        let costTitleLabel = UILabel()
        costTitleLabel.text = "Cost"
        costTitleLabel.textColor = .gasGreen()
        costTitleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        costTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return costTitleLabel
    }()
    
    let costLabel: UILabel = {
        let costLabel = UILabel()
        costLabel.textColor = .subLabelGray()
        costLabel.font = UIFont.boldSystemFont(ofSize: 13)
        costLabel.translatesAutoresizingMaskIntoConstraints = false
        return costLabel
    }()
    
    let viewButton: UIButton = {
        let viewButton = UIButton()
        viewButton.setTitle("View", for: .normal)
        viewButton.setTitleColor(.gasGreen(), for: .normal)
        viewButton.translatesAutoresizingMaskIntoConstraints = false
        return viewButton
    }()
    
    var trip: Trip? {
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
        contentView.addSubview(mapImageView)
        contentView.addSubview(detailView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(participantsLabel)
        contentView.addSubview(destinationTitleLabel)
        contentView.addSubview(destinationLabel)
        contentView.addSubview(costTitleLabel)
        contentView.addSubview(costLabel)
        contentView.addSubview(viewButton)
        
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
        participantsLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        destinationTitleLabel.topAnchor.constraint(equalTo: mapImageView.bottomAnchor, constant: 0).isActive = true
        destinationTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        destinationTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 15).isActive = true
        
        destinationLabel.topAnchor.constraint(equalTo: destinationTitleLabel.bottomAnchor, constant: 0).isActive = true
        destinationLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        destinationLabel.rightAnchor.constraint(equalTo: viewButton.leftAnchor, constant: -15).isActive = true
   
        costTitleLabel.topAnchor.constraint(equalTo: destinationLabel.bottomAnchor, constant: 3).isActive = true
        costTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        
        costLabel.topAnchor.constraint(equalTo: costTitleLabel.bottomAnchor, constant: 0).isActive = true
        costLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        
        viewButton.centerYAnchor.constraint(equalTo: detailView.centerYAnchor).isActive = true
        viewButton.rightAnchor.constraint(equalTo: detailView.rightAnchor, constant: -15).isActive = true
        viewButton.heightAnchor.constraint(equalTo: detailView.heightAnchor, multiplier: 0.5).isActive = true
        viewButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func setData() {
        guard let trip = trip else { return }
        
        titleLabel.text = trip.name
        participantsLabel.text = "\(trip.participants.count) participants"
        destinationLabel.text = trip.destination
        
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let formattedTotalCost = formatter.string(from: trip.totalCost as NSNumber) {
            costLabel.text = "\(formattedTotalCost)"
        }
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
