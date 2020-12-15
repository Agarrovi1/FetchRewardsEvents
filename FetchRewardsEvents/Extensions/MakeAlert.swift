//
//  MakeAlert.swift
//  FetchRewardsEvents
//
//  Created by Angela Garrovillas on 12/14/20.
//  Copyright © 2020 Angela Garrovillas. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func makeAlert(error: AppError) {
        var message = ""
        switch error {
        case .dataError:
            message = "No data found"
        case .decodingError:
            message = "Trouble decoding events"
        case .urlError:
            message = "Invalid query"
        case .imageError:
            message = "Unable to load image"
        case .errorFound:
            message = "Error found while making network call"
        case .favError:
            message = "Error while handling Favorites"
        case .noFavError:
            message = "No favorites"
        }
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
        
    }
}
