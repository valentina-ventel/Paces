//
//  ExtensionNewRunViewController.swift
//  Paces
//
//  Created by Valentina Vențel on 18/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

extension ActivityViewController: CLLocationManagerDelegate {
//    func getCityAndCountry(from location: CLLocation, completion: @escaping(_ city: String?, _ country: String?, _ error: Error?) -> ()) {
//        CLGeocoder().reverseGeocodeLocation(location) { placemark, error in
//            completion(placemark?.first?.locality,
//                       placemark?.first?.country,
//                       error)
//        }
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for newLocation in locations {
            let howRecent = newLocation.timestamp.timeIntervalSinceNow
            guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }

            if let lastLocation = locationList.last {
                let delta = newLocation.distance(from: lastLocation)
                distanceInMeters = distanceInMeters + Measurement(value: delta, unit: UnitLength.meters)
                let coordinates = [lastLocation.coordinate, newLocation.coordinate]
                mapView.addOverlay(MKPolyline(coordinates: coordinates, count: 2))
                let region = MKCoordinateRegion(center: newLocation.coordinate,latitudinalMeters: 500,
                                                longitudinalMeters: 500)
                mapView.setRegion(region, animated: true)
            }
            locationList.append(newLocation)
        }
    }
}
