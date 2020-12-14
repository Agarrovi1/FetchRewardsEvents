//
//  MainTabBarController.swift
//  FetchRewardsEvents
//
//  Created by Angela Garrovillas on 12/7/20.
//  Copyright © 2020 Angela Garrovillas. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    private var eventVC: EventsVC = {
        let vc = EventsVC()
        vc.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        return vc
    }()
    private var favVC: FavoritesVC = {
        let fav = FavoritesVC()
        fav.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 1)
        return fav
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let navEvents = UINavigationController(rootViewController: eventVC)
        let navFav = UINavigationController(rootViewController: favVC)
        viewControllers = [navEvents,navFav]
    }
}
