//
//  DBManager.swift
//  Paces
//
//  Created by Valentina Vențel on 21/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import RealmSwift

class DBManager: NSObject {
    static func saveRun(rute: Route) {
        let realm = try! Realm()
        
        let rlmRoute = RLMRoute(route: rute)
            
        try! realm.write {
            realm.add(rlmRoute)
        }
    }
    
    static func myActivities() -> [RLMRoute] {
        print(Realm.Configuration.defaultConfiguration.fileURL as Any)
        let realm = try! Realm()
        let runs = realm.objects(RLMRoute.self)
        
        return Array(runs)
    }
    
    static func myLastActivity() -> RLMRoute {
        let realm = try! Realm()
        let runs = Array(realm.objects(RLMRoute.self))
        
        return runs.last!
    }
}
