//
//  FavoritesVC.swift
//  FetchRewardsEvents
//
//  Created by Angela Garrovillas on 12/8/20.
//  Copyright © 2020 Angela Garrovillas. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {
    private var favMainView = FavMainView()
    private var favoriteIds = [Int]() {
        didSet {
            let idStr = makeIdString(ids: favoriteIds)
            loadFavEvents(idString: idStr)
        }
    }
    private var favEvents = [Event]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.favMainView.favTableView.reloadData()
            }
        }
    }
    private let api = APIClient()
    
    override func loadView() {
        view = favMainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configFavVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPersistedFav()
    }
    
    private func configFavVC() {
        setFavDelegates()
        loadPersistedFav()
        navigationItem.title = "Favorites"
    }
    
    private func setFavDelegates() {
        favMainView.favTableView.delegate = self
        favMainView.favTableView.dataSource = self
    }
    
    private func loadPersistedFav() {
        do {
            let ids = try Persistence.shared.getObjects()
            favoriteIds = ids
        } catch {
            print(error)
        }
    }
    
    private func makeIdString(ids: [Int]) -> String {
        var str = ids.reduce("") { (ids, nextId) -> String in
            return ids + "\(nextId),"
        }
        let _ = str.popLast()
        return str
    }
    
    private func loadFavEvents(idString: String) {
        api.getEventsBy(ids: idString) { [weak self] (results) in
            switch results {
            case .failure(let error):
                print(error)
            case .success(let events):
                self?.favEvents = events
            }
        }
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

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.reuseID) as? EventCell else {
            return UITableViewCell()
        }
        let event = favEvents[indexPath.row]
        cell.configureCell(event: event, indexPath: indexPath, VCDelegate: self)
        if event.performers.count > 0 {
            loadImage(url: event.performers[0].image, cell: cell)
        }
        if favoriteIds.contains(event.id) {
            cell.favButton.heartStatus = .filled
            cell.favButton.fillHeart()
        } else {
            cell.favButton.heartStatus = .unfilled
            cell.favButton.unfillHeart()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.frame.height * 0.25
    }
}

extension FavoritesVC: FavDelegate {
    func favorited(tag: Int) {
        let event = favEvents[tag]
        do {
            try Persistence.shared.save(event.id)
            loadPersistedFav()
        } catch {
            print(error)
        }
    }
    
    func unfavorited(tag: Int) {
        let event = favEvents[tag]
        do {
            try Persistence.shared.delete(event.id)
            loadPersistedFav()
        } catch {
            print(error)
        }
    }
}
