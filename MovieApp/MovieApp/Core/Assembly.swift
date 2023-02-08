//
//  Assembly.swift
//  MovieApp
//
//  Created by Sailau Almaz Maratuly on 08.02.2023.
//

import Foundation
import UIKit

final class Assembly {
    static let assembler: Assembly = .init()
    private init() {}
    
    func tabBarController() -> UIViewController {
        let tabbar = UITabBarController()
        
        let mainVC = UINavigationController(rootViewController: MainViewController())
        mainVC.tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "film"), tag: 0)
        
        let placesVC = UINavigationController(rootViewController: PlacesViewController())
        placesVC.tabBarItem = UITabBarItem(title: "Places", image: UIImage(systemName: "safari"), tag: 1)

        let ticketsVC = UINavigationController(rootViewController: TicketsViewController())
        ticketsVC.tabBarItem = UITabBarItem(title: "Ticket", image: UIImage(systemName: "ticket"), tag: 2)

        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)

        tabbar.viewControllers = [mainVC, placesVC, ticketsVC, profileVC]
        tabbar.tabBarItem.imageInsets = .init(top: 5, left: 0, bottom: -5, right: 0)
        tabbar.tabBar.barTintColor = .backgroundGray
        tabbar.tabBar.backgroundColor = .backgroundGray

        return tabbar
    }
}
