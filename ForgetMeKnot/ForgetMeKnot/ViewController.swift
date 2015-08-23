//
//  ViewController.swift
//  ForgetMeKnot
//
//  Created by Isaías Lima on 22/08/15.
//  Copyright © 2015 Knot. All rights reserved.
//

import UIKit
import CoreLocation
import QuartzCore

class ViewController: UIViewController{
    
    // MARK: - Outlets & Privates
    var userDef = NSUserDefaults.standardUserDefaults()
    var beacons = []
    
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblUUID: UILabel!
    @IBOutlet weak var lblMSG: UILabel!
    
    var layer: CALayer!
    var animate: UIView!
    
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
        
        animate = UIView()
        animate.frame = CGRectMake(view.frame.size.width/2 - 10, view.frame.size.height - 50, 20, 20)
        animate.layer.cornerRadius = 10
        animate.backgroundColor = UIColor.blueColor()
        animate.alpha = 0.1
        view.addSubview(animate)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1.2, delay: 0.0, options: .Repeat, animations: {
            self.animate.transform = CGAffineTransformMakeScale(100, 100)
            self.animate.alpha = 0
            }) { (bool: Bool) -> Void in
                self.animate.transform = CGAffineTransformMakeScale(1, 1)
                self.animate.alpha = 0.1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

