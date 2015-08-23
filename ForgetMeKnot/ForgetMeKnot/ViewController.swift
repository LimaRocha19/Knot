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
    
    var animate: UIView!
    var imageView: UIView!
    
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
            } else {
                self.lblID.text = "Procurando..."
                self.lblUUID.text = ""
                self.lblMSG.text = "Onde está?"
            }
        }
        
        animate = UIView()
        animate.frame = CGRectMake(view.frame.size.width/2 - 10, view.frame.size.height - 200, 20, 20)
        animate.layer.cornerRadius = 10
        animate.layer.borderColor = UIColor(red: 240/255, green: 94/255, blue: 63/255, alpha: 1.0).CGColor
        animate.layer.borderWidth = 2
        animate.backgroundColor = UIColor(red: 240/255, green: 94/255, blue: 63/255, alpha: 1.0)
        animate.alpha = 0.4
        view.addSubview(animate)
        
        imageView = UIView()
        imageView.frame = CGRectMake(view.frame.size.width/2 - 20, view.frame.size.height - 210, 40, 40)
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = UIColor(red: 240/255, green: 94/255, blue: 63/255, alpha: 1.0)
        view.addSubview(imageView)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(1.5, delay: 0.0, options: .Repeat, animations: {
            self.animate.transform = CGAffineTransformMakeScale(100, 100)
            self.animate.alpha = 0
            }) { (bool: Bool) -> Void in
                self.animate.transform = CGAffineTransformMakeScale(1, 1)
                self.animate.alpha = 0.4
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

