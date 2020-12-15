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
    private var favorites = [Int]()
    private let api = APIClient()
    private let eventsMainView = EventsMainView()
    
    override func loadView() {
        view = eventsMainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        loadFavorites()
        navigationItem.title = "Search Events"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
        DispatchQueue.main.async { [weak self] in
            self?.eventsMainView.eventTableView.reloadData()
        }
    }
    
    private func loadEvents(search: String) {
        api.getEvents(query: search) { [weak self] (results) in
            switch results {
            case .failure(let error):
                self?.makeAlert(title: "Network Call Error", message: "\(error.localizedDescription)")
            case .success(let eventsFromJSON):
                self?.events = eventsFromJSON
            }
        }
    }
    
    private func setDelegates() {
        eventsMainView.eventTableView.dataSource = self
        eventsMainView.eventTableView.delegate = self
        eventsMainView.searchBar.delegate = self
    }
    
    private func loadImage(url: String,cell: EventCell) {
        api.getImageData(urlString: url) { [weak cell, weak self] (results) in
            switch results {
            case .failure(_):
                self?.makeAlert(title: "Image Error", message: "Couldn't find image data")
            case .success(let imageData):
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    cell?.eventImage.image = image
                }
            }
        }
    }
    
    private func loadFavorites() {
        do {
            let favoritedIds = try Persistence.shared.getObjects()
            favorites = favoritedIds
        } catch {
            makeAlert(title: "Favorites Error", message: "Trouble loading favorites")
        }
    }
}

extension EventsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.reuseID) as? EventCell else {
            return UITableViewCell()
        }
        let event = events[indexPath.row]
        cell.configureCell(event: event, indexPath: indexPath, VCDelegate: self)
        if event.performers.count > 0 {
            loadImage(url: event.performers[0].image, cell: cell)
        }
        if favorites.contains(event.id) {
            cell.favButton.heartStatus = .filled
            cell.favButton.fillHeart()
        } else {
            cell.favButton.heartStatus = .unfilled
            cell.favButton.unfillHeart()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = EventDetailVC(event: events[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.height * 0.25
    }
}

extension EventsVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadEvents(search: searchBar.text ?? "")
    }
}

extension EventsVC: FavDelegate {
    func favorited(tag: Int) {
        let event = events[tag]
        do {
            try Persistence.shared.save(event.id)
            loadFavorites()
        } catch {
            makeAlert(title: "Favorites Error", message: "Couldn't save event")
        }
        
    }
    
    func unfavorited(tag: Int) {
        let event = events[tag]
        do {
            try Persistence.shared.delete(event.id)
            loadFavorites()
        } catch {
            makeAlert(title: "Favorites Error", message: "Couldn't delete event")
        }
    }
}

