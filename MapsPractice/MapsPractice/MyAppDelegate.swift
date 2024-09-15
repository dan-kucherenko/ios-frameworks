//
//  MyAppDelegate.swift
//  MapsPractice
//
//  Created by Daniil on 13.09.2024.
//

import UIKit
import GoogleMaps

class MyAppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        // Record the device token.
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GMSServices.provideAPIKey("AIzaSyCajzW0-LkDmPYpc2B7p7ZK72B9ES8xUQE")
    }
}
