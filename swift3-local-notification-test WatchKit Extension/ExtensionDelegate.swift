//
//  ExtensionDelegate.swift
//  swift3-local-notification-test WatchKit Extension
//
//  Created by Drew Westcott on 06/12/2016.
//  Copyright © 2016 Drew Westcott. All rights reserved.
//

import WatchKit
import UserNotifications

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {

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

    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompleted()
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompleted()
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompleted()
            default:
                // make sure to complete unhandled task types
                task.setTaskCompleted()
            }
        }
    }

}
extension ExtensionDelegate: UNUserNotificationCenterDelegate {
	
	func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
		completionHandler(.alert)
	}
}
