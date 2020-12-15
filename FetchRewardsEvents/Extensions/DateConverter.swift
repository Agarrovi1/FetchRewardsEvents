//
//  DateConverter.swift
//  FetchRewardsEvents
//
//  Created by Angela Garrovillas on 12/5/20.
//  Copyright © 2020 Angela Garrovillas. All rights reserved.
//

import Foundation
extension String {
    public func convertDate() -> String {
        let beforeDateFormatter = DateFormatter()
        beforeDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = beforeDateFormatter.date(from: self)
        let displayDateFormatter = DateFormatter()
        displayDateFormatter.dateFormat = "E, d MMM yyyy HH:mm a"
        if let date = date {
            return displayDateFormatter.string(from: date)
        }
        return ""
    }
}

