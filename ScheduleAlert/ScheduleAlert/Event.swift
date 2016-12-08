//
//  Event.swift
//  ScheduleAlert
//
//  Created by Leeann Hu on 12/6/16.
//  Copyright © 2016 Aaron Xu. All rights reserved.
//

import UIKit
import UserNotifications

class Event: NSObject {
    
    var hours:String
    var minutes:String
    var PM:String
    var days: [Int]
    var ringtone: (Int, String)
    var eventName: UITextField
    var eventDetails: UITextView
    var notification: UNMutableNotificationContent
    var eventDetailsEmpty: Bool
    var eventON: Bool
    
    init(eventName: UITextField, eventDetails: UITextView, hours:String, minutes: String, PM: String, days: [Int], ringtone: (Int, String), notification: UNMutableNotificationContent, eventDetailsEmpty: Bool, eventON: Bool) {
        self.eventName = eventName
        self.eventDetails = eventDetails
        self.hours = hours
        self.minutes = minutes
        self.PM = PM
        self.days = days
        self.ringtone = ringtone
        self.notification = notification
        self.eventDetailsEmpty = eventDetailsEmpty
        self.eventON = eventON
    }
}
