//
//  ViewController.swift
//  ForgetMeKnot
//
//  Created by Isaías Lima on 22/08/15.
//  Copyright © 2015 Knot. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Outlets & Privates
    @IBOutlet weak var tableView: UITableView!
    var beacons = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beacons.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let beacon = self.beacons[indexPath.row] as! CLBeacon
        var lbl = ""
        switch (beacon.proximity) {
        case .Far:
            lbl = "Far";
            break;
        case .Near:
            lbl = "Near";
            break;
        case .Immediate:
            lbl = "Immediate";
            break;
        case .Unknown:
            lbl = "Unknown";
            break;
        }
        
        cell.textLabel?.text = lbl
        cell.detailTextLabel?.text = "Major: \(beacon.major.intValue), Minor: \(beacon.minor.intValue), RSSI: \(beacon.rssi), UUID: \(beacon.proximityUUID.UUIDString)"
        
        return cell
    }

}

