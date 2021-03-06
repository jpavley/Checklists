//
//  ChecklistItem.swift
//  Checklists
//
//  Created by John Pavley on 1/11/19.
//  Copyright © 2019 John Pavley. All rights reserved.
//

import Foundation
import UserNotifications

class ChecklistItem: NSObject, Codable {
    var text = ""
    var checked = false
    
    // local notification properties
    var dueDate = Date()
    var shouldRemind = false
    var itemID = GK.Index.noIndex
    
    var dueDateAsString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: dueDate)
    }
    
    init(text: String = "", checked: Bool = false) {
        super.init()
        
        itemID = ChecklistDataModel.nextChecklistItemID()
        
        self.text = text
        self.checked = checked
    }
    
    deinit {
        removeNotification()
    }
    
    func toggleChecked() {
        checked = !checked
    }
    
    func scheduleNotification() {
        
        removeNotification()
        
        if shouldRemind && dueDate > Date() {
            
            let content = UNMutableNotificationContent()
            content.title = "Reminder:"
            content.body = text
            content.sound = UNNotificationSound.default
            
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            let request = UNNotificationRequest(identifier: "\(itemID)", content: content, trigger: trigger)
            
            let center = UNUserNotificationCenter.current()
            center.add(request)
            
            // for debugging uncomment print statement below
            // print("Scheduled: \(request) for itemID: \(itemID)")
        }
    }
    
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
    }
}
