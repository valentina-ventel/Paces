//
//  StopAction.swift
//  Paces
//
//  Created by Valentina Vențel on 18/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import MapKit

extension ActivityViewController {
    func stop() {
        timer.invalidate()
        stopButton.isHidden = true
        durationInSeconds = Measurement(value: Double(seconds),
                                        unit: UnitDuration.seconds)
        locationManager.stopUpdatingLocation()
       // mapView.fitTo(locationList, mapView)
    }
    
    func save() {
        let route = Route(distance: distanceInMeters,
                          duration: durationInSeconds,
                          date: date, locations: locationList)
        
        DBManager.saveRun(rute: route)
    }
}
