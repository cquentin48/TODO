//
//  Checklist.swift
//  Checklists
//
//  Created by lpiem on 21/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

class Checklist{
    var name:String
    var items:[ChecklistItem]
    
    init(name:String, items:[ChecklistItem]=[ChecklistItem]()) {
        self.name = name
        self.items = items
    }
}
