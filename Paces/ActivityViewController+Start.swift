//
//  StartAction.swift
//  Paces
//
//  Created by Valentina Vențel on 18/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

extension ActivityViewController {
    
    func start() {
        seconds = 0

        distance = Measurement(value: 0, unit: UnitLength.meters)
        locationList.removeAll()
        updateDisplay()
        time = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.eachSecond()
        }
        startLocationUpdates()
    }

    func updateDisplay() {
    
        distanceValueLabel.text = String(format: "%.1f", distance.value)
        timeValueLabel.text = "\(seconds)"
        paceValueLabel.text = "\(0)"
    }

    func eachSecond() {
        seconds += 1
        updateDisplay()
    }

    func startLocationUpdates() {
        locationManager.delegate = self
        locationManager.activityType = .fitness
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
    }
}
