//
//  SelectRingtoneTableViewController.swift
//  ScheduleAlert
//
//  Created by Leeann Hu on 12/6/16.
//  Copyright © 2016 Aaron Xu. All rights reserved.
//

import UIKit
import AVFoundation

class SelectRingtoneTableViewController: UITableViewController {
    
    var ringtones:[(Int, String)] = []
    var selectedRingtone: (Int, String)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        ringtones = [(1000, "new-mail"), (1001, "mail-sent"), (1020, "Anticipate"), (1021, "Bloom"), (1005, "alarm"), (1022, "Calpyso"), (1023, "Choo_Choo"), (1024, "Descent"), (1025, "Fanfare"), (1026, "Ladder"), (1027, "Minuet"), (1028, "News_Flash"), (1029, "Noir"), (1030, "Sherwood_Forest"), (1031, "Spell"), (1032, "Suspense"), (1033, "Telegraph"), (1034, "Tiptoes"), (1035, "Typewriters")]
        selectedRingtone = (4095, "Vibrate")
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
        return ringtones.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ringtone"
        let selectedRingtone = ringtones[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = selectedRingtone.1
        cell.detailTextLabel?.text = selectedRingtone.1
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AudioServicesPlaySystemSound(SystemSoundID(ringtones[indexPath.row].0))
        selectedRingtone = ringtones[indexPath.row]
    }
 

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
