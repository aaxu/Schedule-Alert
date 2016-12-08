//
//  ScheduleAlertListTableViewController.swift
//  ScheduleAlert
//
//  Created by Leeann Hu on 12/5/16.
//  Copyright © 2016 Aaron Xu. All rights reserved.
//

import UIKit
import UserNotifications

class ScheduleAlertListTableViewController: UITableViewController, UNUserNotificationCenterDelegate {
    
    struct listOfEvents {
        static var events : [Event] = []
    }
    
    @IBOutlet weak var goToAddEventButton: UIBarButtonItem!
    
    @IBOutlet weak var goToCalendarButton: UIBarButtonItem!
    
    let center = UNUserNotificationCenter.current()
    var editingCellIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        center.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listOfEvents.events.count
    }
    
    @IBAction func unwindToScheduleAlertListTableViewController(sender: UIStoryboardSegue)
    {
        var eventON = true
        if (editingCellIndex != -1) {
            eventON = listOfEvents.events[editingCellIndex].eventON
        }
        let sourceViewController = sender.source as! AddEventViewController
        if sourceViewController.eventDetails.text.isEmpty {
            sourceViewController.eventDetailsEmpty = true
        } 
        let title = sourceViewController.eventName
        let details = sourceViewController.eventDetails
        let ringtone = sourceViewController.ringtone
        let hours = sourceViewController.hour
        let minutes = sourceViewController.minutes
        let PM = sourceViewController.PM
        let eventDetailsEmpty = sourceViewController.eventDetailsEmpty
        var days : [Int] = []
        if (sourceViewController.sunday.isSelected) {
            days.append(1)
        }
        if (sourceViewController.monday.isSelected) {
            days.append(2)
        }
        if (sourceViewController.tuesday.isSelected) {
            days.append(3)
        }
        if (sourceViewController.wednesday.isSelected) {
            days.append(4)
        }
        if (sourceViewController.thursday.isSelected) {
            days.append(5)
        }
        if (sourceViewController.friday.isSelected) {
            days.append(6)
        }
        if (sourceViewController.saturday.isSelected) {
            days.append(7)
        }
        
//        let date = NSDate()
//        let calender = NSCalendar.current
//        let components = calender.dateComponents([.hour, .minute, .weekday], from: date as Date)
//        let hr = components.hour
//        let min = components.minute
//        let dayOfWeek = components.weekday
        
        let notification = UNMutableNotificationContent()
        notification.title = "EVENT AT " + hours + ":" + minutes + PM
        notification.subtitle = (title?.text!)!
        notification.body = " "
        notification.sound = UNNotificationSound(named: (ringtone.1) + ".caf")
        notification.categoryIdentifier = "general"
        let event = Event(eventName: title!, eventDetails: details!, hours: hours, minutes: minutes, PM: PM, days: days, ringtone: ringtone, notification: notification, eventDetailsEmpty: eventDetailsEmpty, eventON: eventON)
        notification.userInfo = ["minutes":event.minutes]
        ScheduleAlertListTableViewController.prepareNotifications(event:event)
        if (editingCellIndex == -1) {
            listOfEvents.events.append(event)
        } else {
            listOfEvents.events[editingCellIndex] = event
        }
        editingCellIndex = -1
        
        self.tableView.reloadData()
        
    }
    
    class func prepareNotifications(event : Event) {
        for x in event.days {
            var dateInfo = DateComponents()
            var temp = Int(event.hours)
            if (event.PM == "PM" && temp != 12) {
                temp = temp! + 12
            } else if (event.PM == "AM" && temp == 12) {
                temp = 0
            }
            dateInfo.hour = temp
            dateInfo.minute = Int(event.minutes)
            dateInfo.weekday = x
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
//            let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 10.0, repeats: false)
            
            // Create the request object.
            let request = UNNotificationRequest(identifier: (event.eventName.text!) + (event.eventDetails.text!) + String(x), content: event.notification, trigger: trigger)
            
            //Schedules notification

            
            UNUserNotificationCenter.current().add(request) { (error : Error?) in
                if let theError = error {
                    print(theError.localizedDescription)
                }
            }
            
            //Creates 30 min warning alert
            var newMinute = dateInfo.minute! - 30
            var newHour = dateInfo.hour!
            var newWeekday = dateInfo.weekday!
            if (dateInfo.minute! < 30) {
                newMinute = newMinute + 60
                newHour = newHour - 1
                if (dateInfo.hour == 0) {
                    newHour = newHour + 24
                    newWeekday = newWeekday - 1
                    if (dateInfo.weekday == 1) {
                        newWeekday = newWeekday + 7
                    }
                }
            }
            dateInfo.hour = newHour
            dateInfo.minute = newMinute
            dateInfo.weekday = newWeekday
            
            let warningTrigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
            //            let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 10.0, repeats: false)
            
            // Create the request object.
            let warningRequest = UNNotificationRequest(identifier: (event.eventName.text!) + (event.eventDetails.text!) + String(x) + "warning", content: event.notification, trigger: warningTrigger)
            
            UNUserNotificationCenter.current().add(warningRequest) { (error : Error?) in
                if let theError = error {
                    print(theError.localizedDescription)
                }
            }
            
//            //Call if notifications not showing up because too many are pending
//            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            
//            //Show pending notifications
//            UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { requests in
//                for request in requests {
//                    print(request)
//                }
//            })
        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Notification being triggered")
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
        completionHandler( [.alert,.sound,.badge])
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "event"
        let selectedEvent = listOfEvents.events[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EventCellTableViewCell
        
        let time = selectedEvent.hours + ":" + selectedEvent.minutes + selectedEvent.PM
        let name = selectedEvent.eventName.text
        cell.alarmLabel.text = time + " - " + name!
        cell.event = selectedEvent
        let temp = selectedEvent.eventON
        cell.turningAlarmOff(cell: cell, sender: cell.alarmStatus)
        if (temp) {
            cell.turningAlarmOn(cell: cell, sender: cell.alarmStatus)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editEventSegue") {
            let dest = segue.destination as! AddEventViewController
            let index = tableView.indexPathForSelectedRow?.row
            editingCellIndex = index!
            let tempEvent = listOfEvents.events[index!]
            dest.currentEventName = tempEvent.eventName.text!
            dest.currentEventDetails = tempEvent.eventDetails.text
            dest.ringtone = tempEvent.ringtone
            dest.days = tempEvent.days
            dest.currentHours = tempEvent.hours
            dest.currentMinutes = tempEvent.minutes
            dest.eventDetailsEmpty = tempEvent.eventDetailsEmpty
            dest.hour = tempEvent.hours
            dest.minutes = tempEvent.minutes
            dest.PM = tempEvent.PM
            if (tempEvent.PM == "PM") {
                dest.currentPM = 1
            }
        } else if (segue.identifier == "addEventSegue") {
            editingCellIndex = -1
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedEvent = listOfEvents.events[indexPath.row]
            for x in 1...7 {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [(deletedEvent.eventName.text!) + (deletedEvent.eventDetails.text)! + String(x)])
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [(deletedEvent.eventName.text!) + (deletedEvent.eventDetails.text)! + String(x) + "warning"])
            }
            listOfEvents.events.remove(at: indexPath.row)
            editingCellIndex = -1
            self.tableView.reloadData()
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.content.categoryIdentifier == "general" {
            // Handle the actions for the expired timer.
            if response.actionIdentifier == "REMIND_LATER" {
                // Invalidate the old timer and create a new one. . .
                let notification = response.notification.request.content
                let identifier = response.notification.request.identifier
                let eventMinutes = notification.userInfo["minutes"] as! String
                let date = NSDate()
                let calender = NSCalendar.current
                let components = calender.dateComponents([.hour, .minute, .weekday], from: date as Date)
                var hr = components.hour
                var min = components.minute
                if (abs(Int(eventMinutes)! - min!) >= 5) {
                    var dateInfo = DateComponents()
                    min = min! + 5
                    if (min! >= 60) {
                        min = min! - 60
                        hr = hr! + 1
                        if (hr! >= 24) {
                            hr = hr! - 24
                        }
                    }
                    dateInfo.hour = hr
                    dateInfo.minute = min
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: false)
                    let warningRequest = UNNotificationRequest(identifier: identifier + "NEW", content: notification, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(warningRequest) { (error : Error?) in
                        if let theError = error {
                            print(theError.localizedDescription)
                        }
                    }
                }
            }
            else if response.actionIdentifier == "DISMISS" {
                // Invalidate the timer. . .
            }
        }
        
        // Else handle actions for other notification types. . .
    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    

}
