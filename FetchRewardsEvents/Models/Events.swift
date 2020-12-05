//
//  Events.swift
//  FetchRewardsEvents
//
//  Created by Angela Garrovillas on 12/5/20.
//  Copyright © 2020 Angela Garrovillas. All rights reserved.
//

import Foundation

struct EventWrapper: Codable {
    let events: [Event]
}

struct Event: Codable {
    let id: Int
    let datetimeUtc: String
    let venue: Venue
    let performers: [Performer]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case datetimeUtc = "datetime_utc"
        case venue = "venue"
        case performers = "performers"
    }
}

struct Venue: Codable {
    let displayLocation: String
    
    enum CodingKeys: String, CodingKey {
        case displayLocation = "display_location"
    }
}

struct Performer: Codable {
    let id: Int
    let name: String
    let image: String
}
