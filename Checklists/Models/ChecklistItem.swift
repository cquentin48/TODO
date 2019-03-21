//
//  ChecklistItem.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import Foundation

class ChecklistItem : Codable {
    var text:String
    var checked:Bool
    var dueDate:Date
    var shouldRemind:Bool
    var itemId:Int
    
    public init(text:String, checked:Bool = false, dueDate:Date=Date.init(timeIntervalSinceNow: 0), shouldRemind:Bool=false, itemId:Int=0){
        self.text = text
        self.checked = checked
        self.dueDate = dueDate
        self.shouldRemind = shouldRemind
        self.itemId = itemId
    }
    
    func toggleChecked(){
        checked = !checked
    }
}

