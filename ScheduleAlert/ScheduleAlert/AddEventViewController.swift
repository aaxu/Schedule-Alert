//
//  AddEventViewController.swift
//  ScheduleAlert
//
//  Created by Leeann Hu on 12/5/16.
//  Copyright © 2016 Aaron Xu. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var eventName: UITextField!
    
    @IBOutlet weak var sunday: UIButton!
    
    @IBOutlet weak var saturday: UIButton!
    
    @IBOutlet weak var friday: UIButton!
    
    @IBOutlet weak var thursday: UIButton!
    
    @IBOutlet weak var wednesday: UIButton!
    
    @IBOutlet weak var tuesday: UIButton!
    
    @IBOutlet weak var monday: UIButton!
    
    @IBOutlet weak var eventDetails: UITextView!
    
    @IBOutlet weak var hoursPicker: UIPickerView!
    
    @IBOutlet weak var PMPicker: UIPickerView!
    
    @IBOutlet weak var minutesPicker: UIPickerView!
    
    var currentEventName = ""
    var currentEventDetails = ""
    var currentHours = "12"
    var currentMinutes = "00"
    var currentPM = 0 //AM
    var eventDetailsEmpty = true
    
    let hoursData = ["12", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
    let minutesData = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09",
                       "10", "11", "12", "13", "14", "15", "16", "17", "18", "19",
                       "20", "21", "22", "23", "24", "25", "26", "27", "28", "29",
                       "30", "31", "32", "33", "34", "35", "36", "37", "38", "39",
                       "40", "41", "42", "43", "44", "45", "46", "47", "48", "49",
                       "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
    let PMData = ["AM", "PM"]
    
    var hour = "12"
    var minutes = "00"
    var PM = "AM"
    var ringtone = (4095, "Vibrate")
    var days : [Int] = []
    @IBOutlet weak var alarmToneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventName.text = currentEventName
        eventDetails.delegate = self
        eventDetails.layer.borderWidth = 1
        eventDetails.layer.borderColor = UIColor.lightGray.cgColor
        eventDetails.layer.cornerRadius = 6
        
        
        if (eventDetailsEmpty) {
            eventDetails.text = "Event Details"
            eventDetails.textColor = UIColor.lightGray
        } else {
            eventDetails.text = currentEventDetails
            eventDetails.textColor = UIColor.black
        }
    
        sunday.setTitleColor(UIColor.green, for: .selected)
        sunday.addTarget(self, action: #selector(turnGreen), for: .touchDown)
        monday.setTitleColor(UIColor.green, for: .selected)
        monday.addTarget(self, action: #selector(turnGreen), for: .touchDown)
        tuesday.setTitleColor(UIColor.green, for: .selected)
        tuesday.addTarget(self, action: #selector(turnGreen), for: .touchDown)
        wednesday.setTitleColor(UIColor.green, for: .selected)
        wednesday.addTarget(self, action: #selector(turnGreen), for: .touchDown)
        thursday.setTitleColor(UIColor.green, for: .selected)
        thursday.addTarget(self, action: #selector(turnGreen), for: .touchDown)
        friday.setTitleColor(UIColor.green, for: .selected)
        friday.addTarget(self, action: #selector(turnGreen), for: .touchDown)
        saturday.setTitleColor(UIColor.green, for: .selected)
        saturday.addTarget(self, action: #selector(turnGreen), for: .touchDown)
        
        let arr = [sunday, monday, tuesday, wednesday, thursday, friday, saturday]
        for x in days {
            arr[x-1]?.isSelected = true
        }
    
        alarmToneButton.setTitle("Alarm tone: " + (ringtone.1), for: .normal)
        
        self.hoursPicker.delegate = self
        self.hoursPicker.dataSource = self
        
        self.minutesPicker.delegate = self
        self.minutesPicker.dataSource = self
        
        self.PMPicker.delegate = self
        self.PMPicker.dataSource = self
        
        
        let maxNum = Int(INT16_MAX)
        hoursPicker.selectRow((maxNum/(2*hoursData.count)) * hoursData.count + Int(currentHours)!, inComponent: 0, animated: false)
        minutesPicker.selectRow((maxNum/(2*minutesData.count)) * minutesData.count + Int(currentMinutes)!, inComponent: 0, animated: false)
        PMPicker.selectRow((maxNum/(2*PMData.count)) * PMData.count + currentPM, inComponent: 0, animated: false)
        
        
//        let screenSize: CGRect = UIScreen.main.bounds
//        
//        let line = Line(frame: CGRect(x: sunday.frame.minX - sunday.frame.width , y: screenSize.minY, width: 1, height: screenSize.height))
//        //object's widths and heights show 500 for some reason. Not synced to storyboard values
//        print(eventDetails.bounds.width)
//        print(sunday.frame.midX)
//        print(wednesday.center)
//        let rect = CGRect(x: screenSize.midX, y: screenSize.midY, width: 30, height: 50)
//        line.draw(rect)
//        line.setNeedsDisplay()
//        self.view.addSubview(line)
//        self.view.setNeedsDisplay()
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func turnGreen(_ button: UIButton) {
        if button.isSelected {
            button.isSelected = false
        } else {
            button.isSelected = true
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
            eventDetailsEmpty = false
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Event Details"
            textView.textColor = UIColor.lightGray
            eventDetailsEmpty = true
        } else {
            eventDetailsEmpty = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if pickerView == hoursPicker {
//            return hoursData.count
//        } else if pickerView == minutesPicker {
//            return minutesData.count
//        } else if pickerView == PMPicker {
//            return PMData.count
//        } else {
//            return 0
//        }
        return Int(INT16_MAX)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100 as CGFloat
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var actualRow = row
        if pickerView == hoursPicker {
            actualRow = row % hoursData.count
            return hoursData[actualRow]
        } else if pickerView == minutesPicker {
            actualRow = row % minutesData.count
            return minutesData[actualRow]
        } else if pickerView == PMPicker {
            actualRow = row % PMData.count
            return PMData[actualRow]
        } else {
            return "0"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        var actualRow = row
        if pickerView == hoursPicker {
            actualRow = row % hoursData.count
            hour = hoursData[actualRow]
        } else if pickerView == minutesPicker {
            actualRow = row % minutesData.count
            minutes = minutesData[actualRow]
        } else if pickerView == PMPicker {
            actualRow = row % PMData.count
            PM = PMData[actualRow]
        }
        
    }
    
    @IBAction func unwindToAddEventViewController(sender: UIStoryboardSegue)
    {
        let sourceViewController = sender.source as! SelectRingtoneTableViewController
        ringtone = sourceViewController.selectedRingtone!
        alarmToneButton.setTitle("Alarm Tone: " + (ringtone.1), for: .normal )
        self.view.setNeedsDisplay()
        
    }
    
//    
//    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//        return 0 as CGFloat
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//        return 0 as CGFloat
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
