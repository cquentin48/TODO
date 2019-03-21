//
//  Preference.swift
//  Checklists
//
//  Created by lpiem on 21/03/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
let preference = Preference()
class Preference{
    
    func nextChecklistItemID() -> Int {
        return UserDefaults.standard.integer(forKey: "checklistItemID")
    }
}
