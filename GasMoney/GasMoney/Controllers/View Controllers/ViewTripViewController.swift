//
//  ViewTripViewController.swift
//  GasMoney
//
//  Created by Jordan Bryant on 12/3/20.
//

import UIKit

class ViewTripViewController: UIViewController {
    
    let nameTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22.5)
        label.textColor = .gasGreen()
        label.text = "Trip Name"
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .gasGray()
        label.text = "California Roadtrip"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let locationsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22.5)
        label.textColor = .gasGreen()
        label.text = "Locations"
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let originLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .gasGray()
        label.text = "Origin: my house"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let destinationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .gasGray()
        label.text = "Destination: San Diego, California"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let participantsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22.5)
        label.textColor = .gasGreen()
        label.text = "Participants"
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let participantsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .gasGray()
        label.text = "Jordan, Kaleb, Owen, John, Dan"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let costsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .gasGreen()
        label.text = "Costs"
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let addCostButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.gasGreen(), for: .normal)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 50)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cellId = "cellId"
    
    var trip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCostButton.addTarget(self, action: #selector(addCostTapped), for: .touchUpInside)
        tableView.register(CostTableViewCell.self, forCellReuseIdentifier: cellId)
        
        setupViews()
        setupTrip()
    }
    
    private func setupTrip() {
        guard let trip = trip else { return }
                
        nameLabel.text = trip.name
        originLabel.text = trip.origin
        destinationLabel.text = trip.destination
        participantsLabel.text = trip.participants.joined(separator: ", ")
    }
    
    private func setupViews() {
        title = "View Trip"
        view.backgroundColor = .offWhite()
        
        view.addSubview(nameTitleLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationsTitleLabel)
        view.addSubview(originLabel)
        view.addSubview(destinationLabel)
        view.addSubview(participantsTitleLabel)
        view.addSubview(participantsLabel)
        view.addSubview(costsTitleLabel)
        view.addSubview(addCostButton)
        view.addSubview(tableView)
        
        nameTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        nameTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        
        nameLabel.anchor(nameTitleLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nameLabel.rightAnchor, topConstant: 3, leftConstant: 15, bottomConstant: 0, rightConstant: 15, widthConstant: 0, heightConstant: 30)
        
        locationsTitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        locationsTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        
        originLabel.anchor(locationsTitleLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nameLabel.rightAnchor, topConstant: 3, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        destinationLabel.anchor(originLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nameLabel.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        participantsTitleLabel.topAnchor.constraint(equalTo: destinationLabel.bottomAnchor, constant: 10).isActive = true
        participantsTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        
        participantsLabel.anchor(participantsTitleLabel.bottomAnchor, left: nameLabel.leftAnchor, bottom: nil, right: nameLabel.rightAnchor, topConstant: 3, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)
        
        costsTitleLabel.topAnchor.constraint(equalTo: participantsLabel.bottomAnchor, constant: 20).isActive = true
        costsTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        
        tableView.anchor(costsTitleLabel.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        addCostButton.centerYAnchor.constraint(equalTo: costsTitleLabel.centerYAnchor).isActive = true
        addCostButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        addCostButton.setHeightAndWidthConstants(height: 60, width: 60)
    }
    
    @objc private func addCostTapped() {
        let alertController = UIAlertController(title: "Add a cost", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Cost name..."
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Cost amount..."
            textField.keyboardType = .decimalPad
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] (_) in
            guard let trip = self?.trip else { return }
            guard let name = alertController.textFields?.first?.text, !name.isEmpty else { return }
            guard let amountString = alertController.textFields?[1].text, !amountString.isEmpty else { return }
            guard let amount = NumberFormatter().number(from: amountString)?.doubleValue else { return }
            
            let cost = Cost(title: name, amount: amount)
            trip.costs.append(cost)
        
            CostController.saveCost(cost: cost, to: trip)
            self?.reloadData()
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func reloadData() {
        self.tableView.reloadData()
    }
    
}

extension ViewTripViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trip?.costs.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! CostTableViewCell
        
        let cost = trip?.costs[indexPath.row]
        
        if let costAmount = cost?.amount {
            cell.costNameLabel.text = cost?.title
            
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            formatter.numberStyle = .currency
            if let formattedCost = formatter.string(from: costAmount as NSNumber) {
                cell.priceLabel.text = "\(formattedCost)".replacingOccurrences(of: ".00", with: "")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
