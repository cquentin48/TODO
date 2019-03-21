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
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?

    
    func checkForNotificationPermission(){
        let center = UNUserNotificationCenter.current()
        // Request permission to display alerts and play sounds.
        center.requestAuthorization(options: [.alert, .sound])
        { (granted, error) in
            if(error != nil){
                print("Ok")
            }else{
                print("Error")
            }
        }
    }
    
    func displayNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Weekly Staff Meeting"
        content.body = "Every Tuesday at 2pm"
        
        let notifDate = Date(timeIntervalSinceNow: 10)
        
        let dateComponents = Calendar.current.dateComponents([.hour,.minute,.second,.day,.month,.year], from: notifDate)
        
        
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
    
    func displayAlert(title:String, message:String, viewController:UIViewController){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(cancelAction)
            viewController.present(alert, animated: true, completion: nil)
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        checkForNotificationPermission()
        UNUserNotificationCenter.current().delegate = self
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

extension AppDelegate : UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(
            [UNNotificationPresentationOptions.alert,
             UNNotificationPresentationOptions.sound,
             UNNotificationPresentationOptions.badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Réponse!")
    }
}
