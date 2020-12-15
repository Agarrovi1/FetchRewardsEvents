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
    func makeAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
        
    }
}
