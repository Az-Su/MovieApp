//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Sailau Almaz Maratuly on 08.02.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = Assembly.assembler.tabBarController()
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
    
    
}

