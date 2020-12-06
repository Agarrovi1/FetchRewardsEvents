//
//  FavButton.swift
//  FetchRewardsEvents
//
//  Created by Angela Garrovillas on 12/6/20.
//  Copyright © 2020 Angela Garrovillas. All rights reserved.
//

import UIKit

enum HeartImage {
    case unfilled
    case filled
}

class FavButton: UIButton {
    
    var pointSize: CGFloat = 0
    var heartStatus = HeartImage.unfilled

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(pointSize: CGFloat) {
        self.init()
        self.pointSize = pointSize
        setupButton(pointSize: pointSize)
    }
    
    private func setupButton(pointSize: CGFloat) {
        let config = UIImage.SymbolConfiguration(pointSize: pointSize)
        let heartImage = UIImage(systemName: "heart", withConfiguration: config)
        setImage(heartImage, for: .normal)
        tintColor = .red
        isUserInteractionEnabled = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    public func changeHeartImage() {
        let config = UIImage.SymbolConfiguration(pointSize: pointSize)
        switch heartStatus {
        case .unfilled:
            let heartFilledImage = UIImage(systemName: "heart.fill", withConfiguration: config)
            setImage(heartFilledImage, for: .normal)
            heartStatus = .filled
        case .filled:
            let heartImage = UIImage(systemName: "heart", withConfiguration: config)
            setImage(heartImage, for: .normal)
            heartStatus = .unfilled
        }
    }
}
