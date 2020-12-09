//
//  UIViewControllerExtension.swift
//  GasMoney
//
//  Created by Jordan Bryant on 11/18/20.
//

import UIKit

extension UIViewController {
    
    func makeNavigationBarClear() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
    }
    
    func removeNavigationBarBackButton() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
}
