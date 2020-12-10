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
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Trip Name"
        label.textColor = .gasGreen()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: GasMoneyTextField = {
        let textField = GasMoneyTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Enter trip name...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)])
        textField.backgroundColor = .subLabelGray()
        textField.autocorrectionType = .no
        textField.layer.borderColor = UIColor.gasGray().cgColor
        textField.clearButtonMode = .whileEditing
        textField.tag = 0
        return textField
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
    
    let addParticipantButton: RoundedButton = {
        let button = RoundedButton()
        button.setTitle("Add Participant", for: .normal)
        button.backgroundColor = .gasGreen()
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let noParticipantsLabel: UILabel = {
        let label = UILabel()
        label.text = "No participants"
        label.textColor = .gasGray()
        label.font = .systemFont(ofSize: 17.5)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    var participants: [String] = []
    
    let cellID = "createTripCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        destinationTextField.delegate = self
        originTextField.delegate = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        addParticipantButton.addTarget(self, action: #selector(addParticipantTapped), for: .touchUpInside)
        
        setupViews()
    }
    
    private func setupViews() {
        title = "Create Trip"
        view.backgroundColor = .offWhite()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finish", style: .plain, target: self, action: #selector(finishButtonTapped))
        
        tableView.tableFooterView = UIView()
        
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(locationLabel)
        view.addSubview(destinationTextField)
        view.addSubview(originTextField)
        view.addSubview(participantsLabel)
        view.addSubview(noParticipantsLabel)
        view.addSubview(tableView)
        view.addSubview(addParticipantButton)
        
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.setHeightAndWidthConstants(height: 25, width: view.frame.width * 0.8)
        
        nameTextField.anchor(nameLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nameLabel.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
        locationLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15).isActive = true
        locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        locationLabel.setHeightAndWidthConstants(height: 25, width: view.frame.width * 0.8)

        destinationTextField.anchor(locationLabel.bottomAnchor, left: locationLabel.leftAnchor, bottom: nil, right: locationLabel.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
        originTextField.anchor( destinationTextField.bottomAnchor, left: locationLabel.leftAnchor, bottom: nil, right: locationLabel.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)
        
        participantsLabel.topAnchor.constraint(equalTo: originTextField.bottomAnchor, constant: 30).isActive = true
        participantsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        participantsLabel.setHeightAndWidthConstants(height: 25, width: view.frame.width * 0.8)
       
        tableView.anchor(participantsLabel.bottomAnchor, left: view.leftAnchor, bottom: addParticipantButton.topAnchor, right: view.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 15, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        addParticipantButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        addParticipantButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addParticipantButton.setHeightAndWidthConstants(height: 60, width: view.frame.width * 0.8)
        
        noParticipantsLabel.centerInView(view: tableView)
    }
    
    @objc private func addParticipantTapped() {
        let addParticipantsVC = AddParticipantViewController()
        addParticipantsVC.delegate = self
        
        navigationController?.pushViewController(addParticipantsVC, animated: true)
    }
    
    @objc private func finishButtonTapped() {
        guard let name = nameTextField.text, !name.isEmpty else { showErrorMessage(); return }
        guard let origin = originTextField.text, !origin.isEmpty else { showErrorMessage(); return }
        guard let destination = destinationTextField.text, !destination.isEmpty else { showErrorMessage(); return }
        
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let id = String((0..<25).map{ _ in letters.randomElement()! })
        
        let trip = Trip(name: name, id: id, destination: destination, origin: origin, participants: [], description: nil, costs: [])
        
        InvitationController.addParticipants(trip: trip, participants: participants)
        
        TripController.createNewTrip(trip: trip)
        navigationController?.popViewController(animated: true)
    }
    
    private func showErrorMessage() {
        Helpers.showNotificationBanner(title: "Couldn't create the trip", subtitle: "Make sure all the fields are filled out.", image: nil, style: .danger, textAlignment: .left)
    }
    
    private func reloadData() {
        self.tableView.reloadData()
        
        noParticipantsLabel.isHidden = !participants.isEmpty
    }
}

extension CreateTripViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participants.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let username = participants[indexPath.row]
        
        cell.textLabel?.text = username
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .white
        return cell
    }
    
}

extension CreateTripViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}

extension CreateTripViewController: AddParticipantsDelegate {
    
    func addParticipants(participants: [User]) {
        var participantsSet = Set(self.participants)
        
        for user in participants {
            participantsSet.update(with: user.username)
        }
        
        self.participants = Array(participantsSet)
        
        reloadData()
    }

}
