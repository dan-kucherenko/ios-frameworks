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
    ) {}
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        GMSServices.provideAPIKey("AIzaSyALh6FQ5hHZffihP8rt42mXPlGwXk6_mhA")
    }
}
