//
//  CreateTripViewController.swift
//  GasMoney
//
//  Created by Kaleb  Carrizoza on 11/23/20.
//
import UIKit

class CreateTripViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Locations"
        label.textColor = .gasGreen()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let destinationTextField: GasMoneyTextField = {
        let textField = GasMoneyTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Enter destination...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
        textField.backgroundColor = .subLabelGray()
        textField.autocorrectionType = .no
        textField.layer.borderColor = UIColor.gasGray().cgColor
        textField.clearButtonMode = .whileEditing
        textField.tag = 0
        return textField
    }()
    
    let originTextField: GasMoneyTextField = {
        let textField = GasMoneyTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Enter starting location...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
        textField.backgroundColor = .subLabelGray()
        textField.autocorrectionType = .no
        textField.layer.borderColor = UIColor.gasGray().cgColor
        textField.clearButtonMode = .whileEditing
        textField.tag = 1
        return textField
    }()
    
    let participantsLabel: UILabel = {
        let label = UILabel()
        label.text = "Participants"
        label.textColor = .gasGreen()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cellID = "createTripCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        setupViews()
    }
    
    private func setupViews() {
        title = "Create Trip"
        view.backgroundColor = .offWhite()
        
        tableView.tableFooterView = UIView()
        
        view.addSubview(locationLabel)
        view.addSubview(destinationTextField)
        view.addSubview(originTextField)
        view.addSubview(participantsLabel)
        view.addSubview(tableView)
        
        locationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        locationLabel.setHeightAndWidthConstants(height: 25, width: view.frame.width * 0.8)

        destinationTextField.anchor(locationLabel.bottomAnchor, left: locationLabel.leftAnchor, bottom: nil, right: locationLabel.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
        originTextField.anchor( destinationTextField.bottomAnchor, left: locationLabel.leftAnchor, bottom: nil, right: locationLabel.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
        participantsLabel.topAnchor.constraint(equalTo: originTextField.bottomAnchor, constant: 30).isActive = true
        participantsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        participantsLabel.setHeightAndWidthConstants(height: 25, width: view.frame.width * 0.8)
       
        tableView.anchor(participantsLabel.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}

extension CreateTripViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.text = "fsdsdg"
        return cell
    }
}
