//
//  EventDetailVC.swift
//  FetchRewardsEvents
//
//  Created by Angela Garrovillas on 12/5/20.
//  Copyright © 2020 Angela Garrovillas. All rights reserved.
//

import UIKit

class EventDetailVC: UIViewController {
    private let detailMainView = DetailView()
    private var favorites = [Int]()
    private var event: Event
    private let api = APIClient()
    
    init(event: Event) {
        self.event = event
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetails()
        loadFavorites()
        setupFavButton()
    }
    
    override func loadView() {
        super.loadView()
        view = detailMainView
    }
    
    private func configureDetails() {
        loadDetailImage()
        detailMainView.detailLocationLabel.text = event.venue.displayLocation
        setupNavBar(title: event.title)
        detailMainView.detailDateLabel.text = event.datetimeUtc.convertDate()
        detailMainView.detailFavButton.addTarget(self, action: #selector(detailFavButtonTapped), for: .touchUpInside)
    }
    
    private func setupNavBar(title: String) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.numberOfLines = 2
        navigationItem.titleView = titleLabel
    }
    
    private func setupFavButton() {
        if favorites.contains(event.id) {
            detailMainView.detailFavButton.heartStatus = .filled
            detailMainView.detailFavButton.fillHeart()
        }
    }
    
    private func loadFavorites() {
        do {
            let ids = try Persistence.shared.getObjects()
            favorites = ids
        } catch {
            makeAlert(error: .favError)
        }
    }
    
    private func loadDetailImage() {
        api.getImageData(urlString: event.performers[0].image) { [weak self] (results) in
            switch results {
            case .failure(let error):
                self?.makeAlert(error: error)
            case .success(let imageData):
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self?.detailMainView.detailImageView.image = image
                }
            }
        }
    }
    
    @objc private func detailFavButtonTapped() {
        detailMainView.detailFavButton.changeHeartImage()
        animateButton()
        switch detailMainView.detailFavButton.heartStatus {
        case .filled:
            do {
                try Persistence.shared.save(event.id)
            } catch {
                makeAlert(error: .favError)
            }
        case .unfilled:
            do {
                try Persistence.shared.delete(event.id)
            } catch {
                makeAlert(error: .favError)
            }
        }
    }
    
    private func animateButton() {
        UIView.animate(withDuration: 0.3, animations: {
            self.detailMainView.detailFavButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { (complete) in
            
            self.detailMainView.detailFavButton.transform = .identity
        }
    }
}
