//
//  EventCellTableViewCell.swift
//  ScheduleAlert
//
//  Created by Leeann Hu on 12/6/16.
//  Copyright © 2016 Aaron Xu. All rights reserved.
//

import UIKit
import UserNotifications

class EventCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var alarmStatus: UISwitch!
    
    @IBOutlet weak var alarmLabel: UILabel!
    
    var event: Event?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        alarmLabel.textColor = UIColor.green
        alarmStatus.addTarget(self, action: #selector(turnAlarmOn), for: .valueChanged)
    }
    
    func turnAlarmOn(_ sender: UISwitch) {
        if (sender.isOn) {
            turningAlarmOff(cell: self, sender: sender)
        } else {
            turningAlarmOn(cell: self, sender: sender)
        }
    }
    
    func turningAlarmOff(cell: EventCellTableViewCell, sender: UISwitch) {
        sender.setOn(false, animated: true)
        alarmLabel.textColor = UIColor.gray
        event!.eventON = false
        for x in 1...7 {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [(event?.eventName.text!)! + (event?.eventDetails.text)! + String(x)])
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [(event?.eventName.text!)! + (event?.eventDetails.text)! + String(x) + "warning"])
        }
    }
    func turningAlarmOn(cell: EventCellTableViewCell, sender: UISwitch) {
        sender.setOn(true, animated: true)
        ScheduleAlertListTableViewController.prepareNotifications(event: event!)
        event!.eventON = true
        alarmLabel.textColor = UIColor.green
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
