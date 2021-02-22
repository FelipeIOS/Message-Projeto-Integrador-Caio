//
//  AppDelegate.swift
//  Message
//
//  Created by Caio on 15/02/21.
//

import UIKit
import CoreData
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        let window = UIWindow(frame: UIScreen.main.bounds)
//        let VC = MessageListViewController()
//        let VC = RegisterViewController()
        let VC = LoginViewController()
        let navVC = UINavigationController(rootViewController: VC)
        window.rootViewController = navVC
        self.window = window
        window.makeKeyAndVisible()
        return true
    }


}

