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
    @objc dynamic var city = ""
    @objc dynamic var country = ""
    var locations = List<RLMLocationCoordinate>()
    
    convenience required init(route: Route) {
        self.init()
        self.distance = route.distance.value
        self.duration = route.duration.value
        self.date = route.date
        // adjust date with some days :D
        // self.date = Calendar.current.date(byAdding: .day, value: -36, to: route.date)!
        self.city = route.city
        self.country = route.country
        let rlmLocations = List<RLMLocationCoordinate>()
        
        for location in route.locations {
            let rlmLocation = RLMLocationCoordinate(clLocationCoordinate2D: location.coordinate)
            rlmLocations.append(rlmLocation)
        }
        
        self.locations = rlmLocations
    }
    
    fileprivate var listOfCLLocation: [CLLocation] {
        var listOfCLLocation = [CLLocation]()
        
        for rlmLocation in locations {
            let coord = rlmLocation.clLocationCoordinate2D
            let location = CLLocation(latitude: coord.latitude,
                                      longitude: coord.longitude)
            
            listOfCLLocation.append(location)
        }
        return listOfCLLocation
    }
    
    func route() -> Route {
        
        let route = Route(distance: Measurement(value: self.distance,
                                                unit: UnitLength.meters),
                          duration: Measurement(value: self.duration,
                                                unit: UnitDuration.seconds),
                          date: self.date,
                          locations: self.listOfCLLocation,
                          city: self.city,
                          country: self.country)
        return route
    }
}
