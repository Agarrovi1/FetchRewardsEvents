//
//  EventDetailVC.swift
//  FetchRewardsEvents
//
//  Created by Angela Garrovillas on 12/5/20.
//  Copyright © 2020 Angela Garrovillas. All rights reserved.
//

import UIKit

class EventDetailVC: UIViewController {
    let detailMainView = DetailView()
    
    var heartStatus = HeartImage.unfilled
    var event: Event?
    let api = APIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetails()
    }
    override func loadView() {
        super.loadView()
        view = detailMainView
    }
    
    private func configureDetails() {
        loadDetailImage()
        guard let event = event else {
            return
        }
        detailMainView.detailLocationLabel.text = event.venue.displayLocation
        setupNavBar(title: event.title)
        detailMainView.detailDateLabel.text = convertDate(string: event.datetimeUtc)
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
    
    
    private func loadDetailImage() {
        guard let event = event, event.performers.count > 0 else {
            return
        }
        api.getImageData(urlString: event.performers[0].image) { [weak self] (results) in
            switch results {
            case .failure(let error):
                print(error)
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
        switch heartStatus {
        case .filled:
            return
        case .unfilled:
            return
        }
    }
}
