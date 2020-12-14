//
//  EventCell.swift
//  FetchRewardsEvents
//
//  Created by Angela Garrovillas on 12/5/20.
//  Copyright © 2020 Angela Garrovillas. All rights reserved.
//

import UIKit


class EventCell: UITableViewCell {
    
    static let reuseID = "eventCell"
    public weak var delegate: FavDelegate?
    public var eventImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    public var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.numberOfLines = 3
        return label
    }()
    public var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.numberOfLines = 2
        return dateLabel
    }()
    public var locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        return locationLabel
    }()
    public var favButton = FavButton(pointSize: 40)

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureTableCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableCell() {
        constrainImageView()
        constrainNameLabel()
        constrainLocationLabel()
        constrainDateLabel()
        constrainFavButton()
        favButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func constrainImageView() {
        contentView.addSubview(eventImage)
        NSLayoutConstraint.activate([
            eventImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            eventImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4),
            eventImage.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4),
            eventImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
    }
    
    private func constrainNameLabel() {
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: eventImage.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: eventImage.trailingAnchor, constant: 8),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)])
    }
    
    private func constrainLocationLabel() {
        contentView.addSubview(locationLabel)
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.20),
        ])
    }
    
    private func constrainDateLabel() {
        contentView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func constrainFavButton() {
        contentView.addSubview(favButton)
        NSLayoutConstraint.activate([
            favButton.topAnchor.constraint(equalTo: locationLabel.centerYAnchor),
            favButton.centerXAnchor.constraint(equalTo: eventImage.centerXAnchor)])
    }
    
    @objc private func buttonTapped() {
        favButton.changeHeartImage()
        switch favButton.heartStatus {
        case .filled:
            delegate?.favorited(tag: tag)
        case .unfilled:
            delegate?.unfavorited(tag: tag)
        }
    }
}
