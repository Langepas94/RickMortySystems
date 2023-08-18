//
//  AppDelegate.swift
//  RickMortySystems
//
//  Created by Артём Тюрморезов on 17.08.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NetworkChecker.shared.startMonitoring()
        return true
    }
}

