//
//  MainTabBarController.swift
//  FetchRewardsEvents
//
//  Created by Angela Garrovillas on 12/7/20.
//  Copyright © 2020 Angela Garrovillas. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    private lazy var eventVC: EventsVC = {
        let vc = EventsVC()
        vc.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [eventVC]
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
