//
//  GroupManager.swift
//  ForgetMeKnot
//
//  Created by Rubens Gondek on 11/17/15.
//  Copyright © 2015 Knot. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class GroupManager {
    
    static let sharedInstance = GroupManager()
    static let entityName: String = "Group"
    
    let coreData = CoreDataManager.sharedInstance
    
    private init(){}
    
    // Novo Grupo
    func newGroup() -> Group {
        return NSEntityDescription.insertNewObjectForEntityForName(GroupManager.entityName, inManagedObjectContext: coreData.managedObjectContext!) as! Group
    }
    
    // Todos os Grupos
    func getAllGroups() -> Array<Group>? {
        return coreData.fetchData(GroupManager.entityName, predicate: NSPredicate(format: "TRUEPREDICATE")) as? Array<Group>
    }
    
    // Cria um novo Grupo
    func saveNewGroup(name: String, knotts: [Knott], on: Bool) {
        let g = newGroup()
        
        g.name = name
        g.knotts = knotts
        g.on = on
        
        saveGroup()
    }
    
    // Salva o Group
    func saveGroup() {
        coreData.saveContext()
    }
    
    // Remove um Group
    func removeGroup(g: Group) {
        coreData.managedObjectContext?.deleteObject(g)
        saveGroup()
    }
}
