//
//  AppDelegate.swift
//  Checklists
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
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
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("Fin d'application")
    }


}

