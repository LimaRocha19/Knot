//
//  Knott.swift
//  ForgetMeKnot
//
//  Created by Rubens Gondek on 11/17/15.
//  Copyright © 2015 Knot. All rights reserved.
//

import Foundation
import CoreData

@objc(Knott)
class Knott: NSManagedObject {

    @NSManaged var name: String?
    @NSManaged var uuid: String?
    @NSManaged var on: NSNumber?
    @NSManaged var favorite: NSNumber?

}
