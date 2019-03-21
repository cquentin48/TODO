//
//  ChecklistItem.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import Foundation
import UserNotifications

class ChecklistItem : Codable {
    var text:String
    var checked:Bool
    var dueDate:Date
    var shouldRemind:Bool
    var itemId:Int?
    
    public init(text:String, checked:Bool = false, dueDate:Date=Date.init(timeIntervalSinceNow: 0), shouldRemind:Bool=false){
        self.text = text
        self.checked = checked
        self.dueDate = dueDate
        self.shouldRemind = shouldRemind
        self.itemId = preference.nextChecklistItemID()
    }
    
    public init(text:String, checked:Bool = false, shouldRemind:Bool, dueDate:Date, itemId:Int){
        self.text = text
        self.checked = checked
        self.dueDate = dueDate
        self.shouldRemind = shouldRemind
        self.itemId = itemId
    }
    
    func scheduleNotification(){
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
        center.add(UNNotificationRequest(identifier: String(itemId ?? 0)+text,
                                         content: createNotificationContent(),
                                         trigger:UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)),
                   withCompletionHandler: nil)
    }
    
    func getDateFormat()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YYYY, hh:mm a"
        return dateFormatter.string(from: dueDate)
    }
    
    func createNotificationContent()->UNMutableNotificationContent{
        let content = UNMutableNotificationContent()
        content.title = "Tâche à faire : "+text
        content.body = "Date limite :"+getDateFormat()
        return content
    }
    
    func toggleChecked(){
        checked = !checked
    }
}

