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
        
        fetchTrips()
        setupViews()
    }
    
    private func setupViews() {
        title = "Your Trips"
        view.backgroundColor = .offWhite()
        
        profileNavigationItem()
        addNavigationItem()
        
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
    
    private func profileNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(profileButtonTapped))
    }
    
    @objc func profileButtonTapped() {
        print(123)
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    private func addNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    @objc func addButtonTapped() {
        print("works")
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 30, height: view.frame.height * 0.25)
    }
    
}
