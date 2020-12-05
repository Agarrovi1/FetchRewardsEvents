//
//  EventsVC.swift
//  FetchRewardsEvents
//
//  Created by Angela Garrovillas on 12/5/20.
//  Copyright © 2020 Angela Garrovillas. All rights reserved.
//

import UIKit

class EventsVC: UIViewController {
    private var events = [Event]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.eventsMainView.eventTableView.reloadData()
            }
        }
    }
    private let api = APIClient()
    
    private let eventsMainView = EventsMainView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        loadEvents()
    }
    override func loadView() {
        super.loadView()
        view = eventsMainView
    }
    
    private func loadEvents() {
        api.getEvents(query: "footBall") { [weak self] (results) in
            switch results {
            case .failure(let error):
                print(error)
            case .success(let eventsFromJSON):
                self?.events = eventsFromJSON
            }
        }
    }
    private func setDelegates() {
        eventsMainView.eventTableView.dataSource = self
        eventsMainView.eventTableView.delegate = self
    }
    private func loadImage(url: String,cell: EventCell) {
        api.getImageData(urlString: url) { (results) in
            switch results {
            case .failure(let error):
                print(error)
            case .success(let imageData):
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    cell.eventImage.image = image
                }
            }
        }
    }

}

extension EventsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as? EventCell else {
            return UITableViewCell()
        }
        let event = events[indexPath.row]
        if event.performers.count > 1 {
            loadImage(url: event.performers[0].image, cell: cell)
        }
        cell.nameLabel.text = event.title
        cell.locationLabel.text = event.venue.displayLocation
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.height * 0.25
    }
    
}
