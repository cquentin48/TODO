//
//  AppDelegate.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func checkForNotificationPermission(){
        let center = UNUserNotificationCenter.current()
        // Request permission to display alerts and play sounds.
        center.requestAuthorization(options: [.alert, .sound])
        { (granted, error) in
            if(!granted){
                print("Error : "+error.debugDescription)
                self.displayAlert(title: "Error", message: "In order to use this app, you must enable notification permission. This application will close.", textButton: "Ok")
                exit(EXIT_FAILURE)
            }else{
                self.displayAlert(title: "Success", message: "With this application you'll be able to manage check list", textButton: "Ok")
            }
        }
    }
    
    func displayNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Weekly Staff Meeting"
        content.body = "Every Tuesday at 2pm"
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.weekday = 4
        dateComponents.hour = 9
        dateComponents.minute = 30
        
        // Create the trigger as a repeating event.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)
        
        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                print(error.debugDescription)
            }
        }
    }
    
    func displayAlert(title:String, message:String, textButton:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: textButton, style: .cancel, handler: nil))
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        checkForNotificationPermission()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print("Passage statut inactif")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("Application en arrière plan")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("Application passée en arrière plan")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("Application devenu active")
        displayNotification()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("Fin d'application")
    }


}

