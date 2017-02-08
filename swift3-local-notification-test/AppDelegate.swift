//
//  AppDelegate.swift
//  swift3-local-notification-test
//
//  Created by Drew Westcott on 06/12/2016.
//  Copyright © 2016 Drew Westcott. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (success, error) in
            if success {
                
                let stopAction = UNNotificationAction(identifier: "FINISH", title: "Finish", options: .foreground)
                let anotherAction = UNNotificationAction(identifier: "ANOTHER", title: "Another", options: .foreground)
                let dismissAction = UNNotificationAction(identifier: "DISMISS", title: "Dismiss", options: UNNotificationActionOptions(rawValue: 0))
                
                let notifCategory = UNNotificationCategory(identifier: "ACTIONS", actions: [stopAction,anotherAction,dismissAction], intentIdentifiers: [], options: UNNotificationCategoryOptions(rawValue: 0))
                
                center.setNotificationCategories([notifCategory])
                print("Notifications granted")
                
            } else {
                print("No authorisation")
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
	
	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
		completionHandler(.alert)
	}
}
