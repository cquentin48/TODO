//
//  ChecklistItem.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text:String
    var checked:Bool
    
    public init(text:String, checked:Bool){
        self.text = text
        self.checked = checked
    }
    
    public init(text:String){
        self.text = text
        self.checked = false
    }
    
    public func toggleChecked(){
        if(checked == true){
            checked = false
        }else{
            checked = true
        }
    }
}
