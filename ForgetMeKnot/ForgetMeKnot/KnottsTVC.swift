//
//  KnottsTVC.swift
//  ForgetMeKnot
//
//  Created by Rubens Gondek on 11/17/15.
//  Copyright © 2015 Knot. All rights reserved.
//

import UIKit

class KnottsTVC: UITableViewController {

    var knotts: [Knott]?
    
    let kManager = KnottManager.sharedInstance
    let iBM = iBeaconManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    override func viewWillAppear(animated: Bool) {
        knotts = kManager.getAllKnotts()
        
        for kn in knotts! {
            if kn.on == 1 {
                iBM.startMonitoringKnott(kn)
            }
        }
    }
    
    @IBAction func editingMode(sender: AnyObject) {
        tableView.editing = !tableView.editing
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return knotts!.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section == 0 ? "Favoritos" : "Todos")
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("knottCell", forIndexPath: indexPath) as! KnottTVCell

        // Configure the cell...
        cell.knott = knotts![indexPath.row]
        cell.on.tag = indexPath.row

        return cell
    }
    
    @IBAction func turnOn(sender: UISwitch) {
        let kn = knotts![sender.tag]
        kn.on = sender.on
        kManager.saveKnott()
        if sender.on {
            iBM.startMonitoringKnott(kn)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let knott = knotts![indexPath.row]
            kManager.removeKnott(knott)
            knotts?.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
