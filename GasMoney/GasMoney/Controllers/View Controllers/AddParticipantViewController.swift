//
//  AddParticipantViewController.swift
//  GasMoney
//
//  Created by Jordan Bryant on 12/1/20.
//

import UIKit

protocol AddParticipantsDelegate: AnyObject {
    func addParticipants(participants: [User])
}

class AddParticipantViewController: UIViewController {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .clear
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.backgroundColor = UIColor.gasGray()
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search Users...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let noDataView: NoDataView = {
        let view = NoDataView()
        let image = UIImage(named: "gasMoneyLogo")?.resize(newSize: CGSize(width: view.frame.width * 0.5, height: view.frame.width * 0.5)).withRenderingMode(.alwaysTemplate)
        view.imageView.image = image
        view.imageView.tintColor = .gasGreen()
        view.textLabel.text = "No users"
        view.button.isHidden = true
        view.isHidden = true
        return view
    }()
    
    var delegate: AddParticipantsDelegate?
    
    var users: [User] = []
    
    var participants: [User] = []
    
    let cellId = "cellId"
    var searchText: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        noDataView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finish", style: .plain, target: self, action: #selector(finishButtonTapped))
        
        setupViews()
    }
    
    private func setupViews() {
        title = "Add Participant"
        view.backgroundColor = .offWhite()
        
        view.addSubview(searchBar)
        view.addSubview(noDataView)
        view.addSubview(tableView)
        
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchBar.setHeightAndWidthConstants(height: 40, width: view.frame.width * 0.85)
        
        tableView.anchor(searchBar.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, topConstant: 15, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        noDataView.pinEdgesToView(view: view)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func finishButtonTapped() {
        delegate?.addParticipants(participants: participants)
        navigationController?.popViewController(animated: true)
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
            self.noDataView.isHidden = true
            if let searchText = self.searchText, !searchText.isEmpty {
                if self.users.count == 0 {
                    self.noDataView.isHidden = false
                }
            }
        }
    }
    
}

extension AddParticipantViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let user = users[indexPath.row]
        
        let selectedView = UIView()
        selectedView.backgroundColor = .gasGreen()
        cell.selectedBackgroundView = selectedView
        
        cell.textLabel?.text = user.username
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismissKeyboard()
        let user = users[indexPath.row]
        
        let alertController = UIAlertController(title: "Invite \(user.username) to the trip?", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let inviteAction = UIAlertAction(title: "Invite", style: .default) { [weak self] (_) in
            guard let strongSelf = self else { return }
            
            if !strongSelf.participants.contains(user) {
                strongSelf.participants.append(user)
            } else {
                Helpers.showNotificationBanner(title: "\(user.username) is already a part of this trip.", subtitle: "", image: nil, style: .danger, textAlignment: .center)
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(inviteAction)
        
        present(alertController, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension AddParticipantViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(search), object: nil)
        self.perform(#selector(search), with: nil, afterDelay: 0.5)
        
        self.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != searchText {
            search()
        }
        
        dismissKeyboard()
    }
    
    @objc private func search() {
        if let searchText = searchText, !searchText.isEmpty {
            UserController.searchUsers(searchText: searchText) { [weak self] (users) in
                self?.users = users
                self?.reloadData()
            }
        } else {
            users = []
            reloadData()
        }
    }
    
}
