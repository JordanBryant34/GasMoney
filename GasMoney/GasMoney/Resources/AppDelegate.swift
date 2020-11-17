//
//  AppDelegate.swift
//  GasMoney
//
//  Created by Jordan Bryant on 11/11/20.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
       
        styleNavigationControllers()
        return true
    }
    
    private func styleNavigationControllers() {
        UINavigationBar.appearance().barTintColor = .gasGreen()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
    }
}

