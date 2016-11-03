
# Schedule Alert
## Author
  * Aaron Xu
  
### Never miss an event again! 
This app is similar to an alarm clock. When an event is close the app will 
remind you that you need to get going! It will send you many reminders with
increasing intensity until it is dismissed. 

### Features 
  * When an event is close (default is 30 min and adjustable), the phone will
  vibrate and an alert will appear on the screen. If the phone is locked, the
  app will wake up the screen and display the alert along with a vibration.
  
  * If the alert is not dismissed, as the time gets closer to the event, the
  duration and the intensity of the vibration will increase. When there are 
  5 minutes remaining (changeable), an alarm will sound and the phone will
  vibrate continually until dismissed or 10 minutes have passed.
  
  * The app itself functions essentially like an alarm and you can set
  multiple alarms (with the ability to go off on selected days of the week
  at specific times).
  
  * There will also be a weekly schedule calendar view where you can get an
  overview of where all the alarms are set on which days of the week.
  
  * Each alarm can have a description added to it to show what it's for.
 
### Control Flow
  * Upon opening the app, the user will be presented with a list of all
  upcoming events in order, from top to bottom.
  
  * Tapping an event on this screen will allow the user to change its
  settings.
  
  * On the top left, there will be a button that allows the user
  to see the weekly schedule calendar view with all the alarms set.
  
  * Clicking on a day in the calendar will show in a view similar
  to the initial screen where all the alarms for that day are listed
  Editing and adding alarms in this view is possible.
  
  * On the top right, there will be a button that allows the user
  to add a new task and set the time when it will go off and other settings.
  
  * After adding a new alarm, the view will unwind and user will go back
  to the screen they were in before.
  
### Implementation

#### Model
  * Event.swift
  
  * Day.swift
  
  * Alarm.swift

#### View
  * AlarmTableView (Used for displaying the events in order)
  
  * WeekdayTableView (Displays events in order when user taps calendar)
  
  * CalendarCollectionView (Used to display the calendar)
  
  * AlertView (Used as the alert popup view that the user must dismiss)
  
#### Controller
  * AlarmTableViewController
  
  * WeekdayTableViewController
  
  * CalendarCollectionViewController
  
  * AlertViewController
