//
//  iBeaconManager.swift
//  ForgetMeKnot
//
//  Created by Rubens Gondek on 8/23/15.
//  Copyright © 2015 Knot. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import CoreBluetooth

class iBeaconManager : NSObject, CLLocationManagerDelegate{
    static let sharedInstance = iBeaconManager()
    
    var locationManager: CLLocationManager!
    var lastProximity: CLProximity!
    var beaconRegion: CLBeaconRegion!
    var beaconsArray: [CLBeacon] = []
    var x = 0
    
    func startMonitoringKnott(kn: Knott) {
        let beaconUUID = NSUUID(UUIDString: kn.uuid!)
        let beaconIdentifier = kn.name!
        
        beaconRegion = CLBeaconRegion(proximityUUID: beaconUUID!, identifier: beaconIdentifier)
        
        locationManager = CLLocationManager()
        if locationManager.respondsToSelector(NSSelectorFromString("requestWhenInUseAuthorization")) {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = false
        
        locationManager.startMonitoringForRegion(beaconRegion)
        locationManager.startRangingBeaconsInRegion(beaconRegion)
        locationManager.startUpdatingLocation()
    }
    
    func config() {
        let beaconUUID = NSUUID(UUIDString: "00000000-0000-0000-0000-000000000000")
        let beaconIdentifier = "Knott"
    
        beaconRegion = CLBeaconRegion(proximityUUID: beaconUUID!, identifier: beaconIdentifier)
        
        locationManager = CLLocationManager()
        if locationManager.respondsToSelector(NSSelectorFromString("requestWhenInUseAuthorization")) {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.delegate = self
        locationManager.pausesLocationUpdatesAutomatically = false
        
        locationManager.startMonitoringForRegion(beaconRegion)
        locationManager.startRangingBeaconsInRegion(beaconRegion)
        locationManager.startUpdatingLocation()
        if #available(iOS 9.0, *) {
            locationManager.allowsBackgroundLocationUpdates = true
        } else {
            // Fallback on earlier versions
        }
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        print("Rodando \(x++)")
        if beacons.count > 0 {
            beaconsArray = beacons
            print(beaconsArray.count)
            NSNotificationCenter.defaultCenter().postNotificationName("beaconChanged", object: nil);
            print("Beacon \(beacons.first?.proximityUUID.UUIDString)")
            let nearestBeacon = beacons.first as CLBeacon!
            if nearestBeacon.proximity == CLProximity.Unknown {
                return
            }
            switch (nearestBeacon.proximity) {
            case .Far:
                sendLocalNotificationWithMessage("Você está esquecendo \(region.identifier)")
                print("Você está esquecendo de algo longe ")
                break
            case .Near:
                print("Você está esquecendo de algo perto")
                break
            default:
                break
            }
        }
    }
    
    func getBeaconsArray() -> Array<CLBeacon>{
        locationManager.startUpdatingLocation()
        locationManager.stopUpdatingLocation()
        return beaconsArray
    }
    
    func sendLocalNotificationWithMessage(message: String) {
        UIApplication.sharedApplication().scheduledLocalNotifications = []
        let notification = UILocalNotification()
        notification.fireDate = NSDate()
        notification.timeZone = NSTimeZone(forSecondsFromGMT: 10800)
        notification.alertBody = message
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
}
