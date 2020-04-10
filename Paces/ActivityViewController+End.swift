//
//  StopAction.swift
//  Paces
//
//  Created by Valentina Vențel on 18/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import MapKit

typealias tupleVar = (String, String)

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
        let saving = {(placemarks: [CLPlacemark]?, error: Error?) -> Void in
            guard let placemarks = placemarks else {
                print("Problem with the data received from geocoder")
                return
            }
            let placemark = placemarks[0]
            let locality = placemark.locality!
            let country = placemark.country!
            print("It was a great activity in \(locality), \(flag(twoDigitCountryCode(for: country)))")
            let route = Route(distance: self.distanceInMeters,
                              duration: self.durationInSeconds,
                              date: self.date,
                              locations: self.locationList,
                              city: locality,
                              country: country)
                    
            DBManager.saveRun(rute: route)
            DBManager.saveDateOfTheActivity(date: self.date)
        }
        
        CLGeocoder().reverseGeocodeLocation(self.locationList.first!,
                                            completionHandler: saving)
    
    }
}
