//
//  TripsListViewController.swift
//  GasMoney
//
//  Created by Kaleb  Carrizoza on 11/16/20.
//

import UIKit
import NVActivityIndicatorView

class TripsListViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 10, right: 0)
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    lazy var activityIndicator: NVActivityIndicatorView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width * 0.15, height: view.frame.width * 0.15)
        let indicator = NVActivityIndicatorView(frame: frame, type: .ballClipRotateMultiple, color: .gasGreen(), padding: nil)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let noDataView: NoDataView = {
        let view = NoDataView()
        let image = UIImage(named: "gasMoneyLogo")?.resize(newSize: CGSize(width: view.frame.width * 0.5, height: view.frame.width * 0.5)).withRenderingMode(.alwaysTemplate)
        view.imageView.image = image
        view.imageView.tintColor = .gasGreen()
        view.textLabel.text = "You have no trips"
        view.detailTextLabel.text = "Create a new trip or join a friends!"
        view.button.setTitle("Create Trip", for: .normal)
        view.isHidden = true
        return view
    }()
    
    let cellID = "cellId"
    
    var trips: [Trip] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(TripCell.self, forCellWithReuseIdentifier: cellID)
        
        noDataView.button.addTarget(self, action: #selector(createTripTapped), for: .touchUpInside)
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchTrips()
    }
    
    private func setupViews() {
        title = "Your Trips"
        view.backgroundColor = .offWhite()
        removeNavigationBarBackButton()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(color: .gasGreen()), for: .default)
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Trip", style: .plain, target: self, action: #selector(createTripTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Invitations", style: .plain, target: self, action: #selector(invitationsTapped))
        
        view.addSubview(noDataView)
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        
        noDataView.pinEdgesToView(view: view)
        collectionView.pinEdgesToView(view: view)
        
        activityIndicator.centerInView(view: view)
        activityIndicator.setHeightAndWidthConstants(height: view.frame.width * 0.15, width: view.frame.width * 0.15)
    }
    
    private func fetchTrips() {
        activityIndicator.startAnimating()
        TripController.fetchUsersTrips { [weak self] (trips) in
            self?.trips = trips
            self?.reloadData()
        }
    }
    
    @objc private func createTripTapped() {
        navigationController?.pushViewController(CreateTripViewController(), animated: true)
    }
    
    @objc private func invitationsTapped() {
        navigationController?.pushViewController(InvitationsViewController(), animated: true)
    }
    
    @objc private func handleViewButtonTapped(sender: UIButton) {
        let viewTripVC = ViewTripViewController()
        let trip = trips[sender.tag]
        
        viewTripVC.trip = trip
        
        navigationController?.pushViewController(viewTripVC, animated: true)
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
            self.noDataView.isHidden = !self.trips.isEmpty
        }
    }
    
}

extension TripsListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trips.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TripCell
        
        cell.trip = trips[indexPath.item]
        
        cell.viewButton.addTarget(self, action: #selector(handleViewButtonTapped), for: .touchUpInside)
        cell.viewButton.tag = indexPath.item
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 30, height: view.frame.height * 0.25)
    }
    
}
