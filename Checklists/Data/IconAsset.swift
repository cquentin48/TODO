//
//  IconAsset.swift
//  Checklists
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

enum IconAsset: String, CaseIterable, Codable {
    case Birthdays
    case Chores
    case Drinks
    case Folder
    case Groceries
    case Inbox
    case NoIcon = "No Icon"
    case Photos
    case Trips
    var image : UIImage {
        return UIImage(named: self.rawValue)!
    }
}
