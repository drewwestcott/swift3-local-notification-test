//
//  InterfaceController.swift
//  swift3-local-notification-test WatchKit Extension
//
//  Created by Drew Westcott on 06/12/2016.
//  Copyright © 2016 Drew Westcott. All rights reserved.
//
//  Exclamation Alert by Luke Peek from the Noun Project
import WatchKit
import UserNotifications

class InterfaceController: WKInterfaceController, UNUserNotificationCenterDelegate {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
    }
    
    @IBAction func startRepeatingNotification(sender: WKInterfaceButton!) {
        
        scheduleANotification()
        
    }
    
    func scheduleANotification() {
        
        let content = UNMutableNotificationContent()
		content.title = "Attention"
		content.subtitle = "Times Up!"
        content.body = "Tap the 'Finish' button to stop being notified."
        
        content.categoryIdentifier = "ACTIONS"
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
		
		let randomIdentifier = Int(arc4random_uniform(25)) // append this to the identifier to get notifications triggering on each 'reschedule'
        let notifyRequest = UNNotificationRequest(identifier: "repeat", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        
        center.add(notifyRequest) { ( error: Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            } else {
                print("Scheduled OK")
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //Fire of the system notification
        completionHandler(UNNotificationPresentationOptions.alert)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print(response.actionIdentifier)
        if response.actionIdentifier == "FINISH" {
            print("Stop Acknowledged")
            center.removeDeliveredNotifications(withIdentifiers: ["repeat"])
            completionHandler()
        } else {
            scheduleANotification()
            print("Recheduled")
            completionHandler()
        }
    }

	
}
