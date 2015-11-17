//
//  KnottManager.swift
//  RemeditoSwift
//
//  Created by Ricardo Hochman on 23/10/15.
//  Copyright © 2015 Gondek. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class KnottManager {
    
    static let sharedInstance = KnottManager()
    static let entityName: String = "Knott"
    
    let coreData = CoreDataManager.sharedInstance
    
    private init(){}
    
    // Novo Knott
    func newKnott() -> Knott {
        return NSEntityDescription.insertNewObjectForEntityForName(KnottManager.entityName, inManagedObjectContext: coreData.managedObjectContext!) as! Knott
    }
    
    // Todos os Knotts
    func getAllKnotts() -> Array<Knott>? {
        return coreData.fetchData(KnottManager.entityName, predicate: NSPredicate(format: "TRUEPREDICATE")) as? Array<Knott>
    }
    
    // Cria um novo Knott
    func saveNewKnott(name: String, uuid: String, on: Bool, fav: Bool) {
        let k = newKnott()
        
        k.name = name
        k.uuid = uuid
        k.on = on
        k.favorite = fav

        saveKnott()
    }
    
    // Salva o Knott
    func saveKnott() {
        coreData.saveContext()
    }
    
    // Remove um Knott
    func removeKnott(k: Knott) {
        coreData.managedObjectContext?.deleteObject(k)
        saveKnott()
    }
}
