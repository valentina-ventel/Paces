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
    
    init(distance: Measurement<UnitLength>,
         duration: Measurement<UnitDuration>,
         date: Date,
         locations: [CLLocation])
    {
        self.distance = distance
        self.duration = duration
        self.date = date
        self.locations = locations
    }
}
