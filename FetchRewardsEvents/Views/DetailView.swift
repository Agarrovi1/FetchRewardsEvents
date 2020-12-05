//
//  DetailView.swift
//  FetchRewardsEvents
//
//  Created by Angela Garrovillas on 12/5/20.
//  Copyright © 2020 Angela Garrovillas. All rights reserved.
//

import UIKit

class DetailView: UIView {

    public var navBar = UINavigationBar()
    public var detailImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.backgroundColor = .systemPink
        return imgView
    }()
    public var detailDateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.backgroundColor = .green
        return dateLabel
    }()
    public var detailLocationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.backgroundColor = .lightGray
        return locationLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDetailView() {
        constrainDetailImage()
        constrainDetailDateLabel()
        constrainDetailLocationLabel()
    }
    private func constrainDetailImage() {
        addSubview(detailImageView)
        NSLayoutConstraint.activate([
            detailImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            detailImageView.widthAnchor.constraint(equalTo: widthAnchor,multiplier: 0.7),
            detailImageView.heightAnchor.constraint(equalTo: widthAnchor,multiplier: 0.7),
            detailImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    private func constrainDetailDateLabel() {
        addSubview(detailDateLabel)
        NSLayoutConstraint.activate([
            detailDateLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 8),
            detailDateLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            detailDateLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1)
        ])
    }
    private func constrainDetailLocationLabel() {
        addSubview(detailLocationLabel)
        NSLayoutConstraint.activate([
            detailLocationLabel.topAnchor.constraint(equalTo: detailDateLabel.bottomAnchor, constant: 8),
            detailLocationLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            detailLocationLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1)
        ])
    }
    
}
