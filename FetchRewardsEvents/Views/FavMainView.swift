//
//  FavMainView.swift
//  FetchRewardsEvents
//
//  Created by Angela Garrovillas on 12/8/20.
//  Copyright © 2020 Angela Garrovillas. All rights reserved.
//

import UIKit

class FavMainView: UIView {

    public lazy var favTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(EventCell.self, forCellReuseIdentifier: "eventCell")
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureFavView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureFavView() {
        constrainFaveTableView()
    }
    
    private func constrainFaveTableView() {
        addSubview(favTableView)
        NSLayoutConstraint.activate([
            favTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            favTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            favTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            favTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
