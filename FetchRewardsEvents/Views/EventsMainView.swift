//
//  EventsMainView.swift
//  FetchRewardsEvents
//
//  Created by Angela Garrovillas on 12/5/20.
//  Copyright © 2020 Angela Garrovillas. All rights reserved.
//

import UIKit

class EventsMainView: UIView {

    public var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.barTintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        search.autocorrectionType = .no
        search.autocapitalizationType = .none
        search.placeholder = "search for events ex: football"
        return search
    }()
    public var eventTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(EventCell.self, forCellReuseIdentifier: "eventCell")
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .systemBlue
        constrainSearchBar()
        constrainTableView()
    }
    
    private func constrainSearchBar() {
        addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor)])
    }
    
    private func constrainTableView() {
        addSubview(eventTableView)
        NSLayoutConstraint.activate([
            eventTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            eventTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            eventTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            eventTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
}
