//
//  AppDelegate.swift
//  Message
//
//  Created by Caio on 15/02/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let VC = MessageListViewController()
        let navVC = UINavigationController(rootViewController: VC)
        window.rootViewController = navVC
        self.window = window
        window.makeKeyAndVisible()
        return true
    }


}

