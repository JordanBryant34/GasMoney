//
//  InvitationsViewController.swift
//  GasMoney
//
//  Created by Owen Gaudio on 11/30/20.
//

import UIKit
import NVActivityIndicatorView

class InvitationsViewController: UIViewController {

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
    
    let cellID = "cellId"
    
    var invitations: [Invitation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(InvitationCell.self, forCellWithReuseIdentifier: cellID)
        setupViews()
    }
    
    private func setupViews() {
        title = "Invitations"
        view.backgroundColor = .offWhite()
        
        view.addSubview(collectionView)
        collectionView.pinEdgesToView(view: view)
    }
}

extension InvitationsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! InvitationCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 30, height: view.frame.height * 0.125)
    }
}
