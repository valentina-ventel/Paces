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
    
    static func saveDateOfTheActivity(date: Date) {
        let realm = try! Realm()
        
        let rlmDate = RLMDateOfTheLastActivity(date: date)
        
        try! realm.write {
            realm.add(rlmDate)
        }
    }
    
    static func myActivities() -> [Route] {
        print(Realm.Configuration.defaultConfiguration.fileURL as Any)
        let realm = try! Realm()
        let rlmRoutes = Array(realm.objects(RLMRoute.self))
        
        var routes = [Route]()
        
        for rlmRoute in rlmRoutes {
            let route = rlmRoute.route()
            
            routes.append(route)
        }
        return routes.sorted(by: {$0.date > $1.date})
    }
    
    static func dateLastRun() -> Date {
        let realm = try! Realm()
        let rlmDates = Array(realm.objects(RLMDateOfTheLastActivity.self))
        
        var dates = [Date]()
        
        for rlmDate in rlmDates {
            dates.append(rlmDate.date)
        }
        
        return dates.last!
    }
}
