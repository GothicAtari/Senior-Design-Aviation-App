//
//  Flying_For_FoodApp.swift
//  Flying For Food
//
//  Created by Rice on 8/17/21.
//

import SwiftUI
import Firebase

@main
struct Flying_For_FoodApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
           SignInController()
        }
    }
    
}

class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        Thread.sleep(forTimeInterval: 1.5)
        FirebaseApp.configure()
        return true
    
}
}
