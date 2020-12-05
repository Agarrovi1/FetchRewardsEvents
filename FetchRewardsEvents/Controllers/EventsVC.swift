//
//  EventsVC.swift
//  FetchRewardsEvents
//
//  Created by Angela Garrovillas on 12/5/20.
//  Copyright © 2020 Angela Garrovillas. All rights reserved.
//

import UIKit

class EventsVC: UIViewController {
    private let eventsMainView = EventsMainView()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func loadView() {
        super.loadView()
        view = eventsMainView
    }

}
