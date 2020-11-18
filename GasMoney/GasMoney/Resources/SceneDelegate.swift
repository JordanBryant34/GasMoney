//
//  SceneDelegate.swift
//  GasMoney
//
//  Created by Jordan Bryant on 11/11/20.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        setUpWindow(windowScene: windowScene)
        checkIfSignedIn()
    }

    func setUpWindow(windowScene: UIWindowScene) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
    }
    
    func checkIfSignedIn() {
        if Auth.auth().currentUser != nil {
            window?.rootViewController = UINavigationController(rootViewController: TripsListViewController())
        } else {
            window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        }
    }
}

