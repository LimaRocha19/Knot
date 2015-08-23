//
//  ViewController.swift
//  ForgetMeKnot
//
//  Created by Isaías Lima on 22/08/15.
//  Copyright © 2015 Knot. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{
    
    // MARK: - Outlets & Privates
    var userDef = NSUserDefaults.standardUserDefaults()
    var beacons = []
    
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblUUID: UILabel!
    @IBOutlet weak var lblMSG: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let notificationCenter = NSNotificationCenter.defaultCenter()
        let mainQueue = NSOperationQueue.mainQueue()
        
        notificationCenter.addObserverForName("beaconChanged", object: nil, queue: mainQueue) { _ in
            self.beacons = iBeaconManager.sharedInstance.beaconsArray
            if self.beacons.count > 0 {
                let beac = self.beacons[0] as! CLBeacon
                self.lblID.text = String(beac.rssi)
                self.lblUUID.text = beac.proximityUUID.UUIDString
                self.lblMSG.text = "Carteira"
            }
        }
        
        
        //        beacons = userDef.valueForKey("arrayBeacons") as! NSArray
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

