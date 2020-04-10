//
//  Route.swift
//  Paces
//
//  Created by Valentina Vențel on 21/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import MapKit

class Route {
    var distance: Measurement<UnitLength>
    var duration: Measurement<UnitDuration>//duration
    var date: Date
    var locations: [CLLocation]
    var city: String
    var country: String
    
    init(distance: Measurement<UnitLength>,
         duration: Measurement<UnitDuration>,
         date: Date,
         locations: [CLLocation],
         city: String,
         country: String)
    {
        self.distance = distance
        self.duration = duration
        self.date = date
        self.locations = locations
        self.city = city
        self.country = country
    }
    
    func locationsListOfCLLocationCoordinate2D() -> [CLLocationCoordinate2D] {
        var locationsOfCLLocationCoordinate2d = [CLLocationCoordinate2D]()
        
        for location in locations {
            let coord = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                               longitude: location.coordinate.longitude)
            
            locationsOfCLLocationCoordinate2d.append(coord)
        }
        return locationsOfCLLocationCoordinate2d
    }
}
