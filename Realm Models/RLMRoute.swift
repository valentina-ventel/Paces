//
//  Route.swift
//  Paces
//
//  Created by Valentina Vențel on 20/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import RealmSwift
import MapKit

class RLMRoute: Object {
    @objc dynamic var distance = 0.0
    @objc dynamic var time = 0
    @objc dynamic var date = ""
    var locations = List<RLMLocationCoordinate>()
    
    var dateInOriginalForm: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        return formatter.date(from: date)!
    }
    
    convenience required init(route: Route) {
        self.init()
        self.distance = route.distance.value
        self.time = route.time
        let rlmLocations = List<RLMLocationCoordinate>()
        
        for location in route.locations {
            let rlmLocation = RLMLocationCoordinate(clLocationCoordinate2D: location.coordinate)
            rlmLocations.append(rlmLocation)
        }
        
        self.locations = rlmLocations
        
        let formater = DateFormatter()
        formater.dateFormat = "HH:mm E, d MMM y"
        
        self.date = formater.string(from: route.date)
    }
}
