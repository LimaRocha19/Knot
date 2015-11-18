//
//  Group.swift
//  ForgetMeKnot
//
//  Created by Rubens Gondek on 11/17/15.
//  Copyright © 2015 Knot. All rights reserved.
//

import Foundation
import CoreData


class Group: NSManagedObject {
    
    @NSManaged var name: String?
    @NSManaged var on: NSNumber?
    @NSManaged var knotts: NSObject?

}
