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
    
    public init(text:String, checked:Bool = false){
        self.text = text
        self.checked = checked
    }
    
    func toggleChecked(){
        checked = !checked
    }
}

