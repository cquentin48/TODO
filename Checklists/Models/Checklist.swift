//
//  Checklist.swift
//  Checklists
//
//  Created by lpiem on 21/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class Checklist : Codable{
    var name:String
    var items:[ChecklistItem]
    
    init(name:String, items:[ChecklistItem]=[ChecklistItem]()) {
        self.name = name
        self.items = items
    }
    
    var remainingItems: Int {
        return items.filter({ (singleCheckListItem) -> Bool in
            !singleCheckListItem.checked
        }).count
    }
}
