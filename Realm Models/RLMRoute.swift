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
import CoreLocation

class RLMRoute: Object {
    @objc dynamic var distance = 0.0
    @objc dynamic var duration = TimeInterval()
    @objc dynamic var date = Date()
    var locations = List<RLMLocationCoordinate>()
    
    convenience required init(route: Route) {
        self.init()
        self.distance = route.distance.value
        self.duration = route.duration.value
        let rlmLocations = List<RLMLocationCoordinate>()
        
        for location in route.locations {
            let rlmLocation = RLMLocationCoordinate(clLocationCoordinate2D: location.coordinate)
            rlmLocations.append(rlmLocation)
        }
        
        self.locations = rlmLocations
            
        self.date = route.date
    }
    
    var locationsOfCLLocation: [CLLocationCoordinate2D] {
        var locationsCLLocation = [CLLocationCoordinate2D]()
        
        for rlmLocation in locations {
            let location = rlmLocation.clLocationCoordinate2D
            
            locationsCLLocation.append(location)
        }
        return locationsCLLocation
    }
}
