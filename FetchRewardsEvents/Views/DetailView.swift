//
//  DetailView.swift
//  FetchRewardsEvents
//
//  Created by Angela Garrovillas on 12/5/20.
//  Copyright © 2020 Angela Garrovillas. All rights reserved.
//

import UIKit

class DetailView: UIView {

    public var detailImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    public var detailDateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.boldSystemFont(ofSize: 18)
        return dateLabel
    }()
    public var detailLocationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        return locationLabel
    }()
    public var detailFavButton = FavButton(pointSize: 40)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDetailView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDetailView() {
        backgroundColor = .white
        constrainDetailImage()
        constrainDetailDateLabel()
        constrainDetailLocationLabel()
        constrainDetailFavButton()
        
    }
    
    private func constrainDetailImage() {
        addSubview(detailImageView)
        NSLayoutConstraint.activate([
            detailImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            detailImageView.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.8),
            detailImageView.heightAnchor.constraint(equalTo: widthAnchor,multiplier: 0.8),
            detailImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    private func constrainDetailDateLabel() {
        addSubview(detailDateLabel)
        NSLayoutConstraint.activate([
            detailDateLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 8),
            detailDateLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            detailDateLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05),
            detailDateLabel.centerXAnchor.constraint(equalTo: detailImageView.centerXAnchor)
        ])
    }
    private func constrainDetailLocationLabel() {
        addSubview(detailLocationLabel)
        NSLayoutConstraint.activate([
            detailLocationLabel.topAnchor.constraint(equalTo: detailDateLabel.bottomAnchor, constant: 8),
            detailLocationLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            detailLocationLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05),
            detailLocationLabel.centerXAnchor.constraint(equalTo: detailImageView.centerXAnchor)
        ])
    }
    private func constrainDetailFavButton() {
        addSubview(detailFavButton)
        NSLayoutConstraint.activate([
            detailFavButton.topAnchor.constraint(equalTo: detailLocationLabel.bottomAnchor, constant:  8),
            detailFavButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
}
