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
    var time: Int
    var date: Date
    var locations: [CLLocation]
    
    init(distance: Measurement<UnitLength>, time: Int, date: Date, locations: [CLLocation]) {
        self.distance = distance
        self.time = time
        self.date = date
        self.locations = locations
    }
}
